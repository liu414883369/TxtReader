//
//  JJTxtParse.m
//  读取txt文件
//
//  Created by liujianjian on 16/5/30.
//  Copyright © 2016年 rdg. All rights reserved.
//

#import "JJTxtParse.h"
#import "JJConst.h"
#import <CoreText/CoreText.h>
#import "JJChapterModel.h"

@interface JJTxtParse()
/**
 *  分割的节点
 */
@property (nonatomic, strong)NSMutableArray *locations;

@property (nonatomic, copy)completeBlock completion;


@end

@implementation JJTxtParse

#pragma mark - setter getter

- (NSMutableArray *)locations {
    if (!_locations) {
        _locations = [NSMutableArray array];
    }
    return _locations;
}
- (NSMutableArray<JJChapterModel *> *)chapters {
    if (!_chapters) {
        _chapters = [NSMutableArray array];
    }
    return _chapters;
}


- (NSUInteger)totalPage {
    return self.locations.count;
}
- (void)startParseWithPath:(NSString *)path completion:(completeBlock)completion onQueue:(dispatch_queue_t)queue {
    
    if (!path.length) return;
    _completion = completion;
    
    if (queue == NULL || queue == dispatch_get_main_queue()) {

        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self readTxtWithPath:path];
        });
    } else {
        dispatch_async(queue, ^{
            [self readTxtWithPath:path];
        });
    }
    
}

// 解析txt
- (void)readTxtWithPath:(NSString *)txtPath {
    
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    // 解析文档
//    NSBlockOperation *parseDoc = [NSBlockOperation blockOperationWithBlock:^{
    
        NSString *path = [[NSBundle mainBundle] pathForResource:@"五界至尊" ofType:@"txt"];
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"shinian" ofType:@"txt"];
    
        
        NSError *error = nil;
        NSString *content = nil; // 解析后结果
        NSStringEncoding stringEncoding; // 编码方式
        
        stringEncoding = NSUTF8StringEncoding; // 1
        
//    stringEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000); // 2
//    stringEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_2312_80); // 3
//    stringEncoding = NSUTF16StringEncoding; // 4
    
        content = [NSString stringWithContentsOfFile:path encoding:stringEncoding error:&error];
        //    NSString *content = [[NSString alloc] initWithContentsOfFile:path usedEncoding:&stringEncoding error:&error];
        
        if (!content.length) {
            stringEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            content = [NSString stringWithContentsOfFile:path encoding:stringEncoding error:&error];
        }
        if (!content.length) {
            stringEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_2312_80);
            content = [NSString stringWithContentsOfFile:path encoding:stringEncoding error:&error];
        }
        if (!content.length) {
            stringEncoding = NSUTF16StringEncoding;
            content = [NSString stringWithContentsOfFile:path encoding:stringEncoding error:&error];
        }
        self.txt = content;
        
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            self.textView.text = self.content;
//            [SVProgressHUD dismiss];
//            self.totalPage = (int)self.textView.contentSize.height / self.textView.height + 1;
//            self.bottomBar.minimumValue = 0;
//            self.bottomBar.maximumValue = self.totalPage;
//            
//        }];
        [self parse];
//    }];
    // 第章节卷 篇 讲 回
    if (self.chapters.count) {
        return;
    }
    NSArray *txtArray = [self.txt componentsSeparatedByString:@"\n"];
    NSString *pattern = @"^[\\s]*\\u7b2c.+[\\u7ae0\\u5377\\u8282\\u7bc7\\u8bb2\\u56de]+.*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", pattern];
    NSArray *result = [txtArray filteredArrayUsingPredicate:predicate];
    [self.chapters removeAllObjects];
    
    for (NSString *chapter in result) {
//
//        NSRange range = [self.txt rangeOfString:chapter];
//
//        JJChapterModel *chapterModel = [[JJChapterModel alloc] init];
//        chapterModel.title = chapter;
//        chapterModel.range = range;
//        [self.chapters addObject:chapterModel];
    
        // pattern：规则
        NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:chapter options:0 error:nil];
        NSArray *results = [regex matchesInString:self.txt options:0 range:NSMakeRange(0, self.txt.length)];
        for (NSTextCheckingResult *result in results) {
            JJChapterModel *chapterModel = [[JJChapterModel alloc] init];
            chapterModel.title = chapter;
            chapterModel.range = result.range;
            [self.chapters addObject:chapterModel];
//            NSLog(@"%@", NSStringFromRange(result.range));
        }
    }
}


/**
 *  解析数据
 */
- (void)parse {
    
    /*
     1、生成要绘制的NSAttributedString对象。 2、生成一个CTFramesetterRef对象，然后创建一个CGPath对象，这个Path对象用于表示可绘制区域坐标值、长宽。 3、使用上面生成的setter和path生成一个CTFrameRef对象，这个对象包含了这两个对象的信息（字体信息、坐标信息），它就可以使用CTFrameDraw方法绘制了。
     */

    // 获取缓存大小字符串
    NSString *buffer = [self stringWithRange:NSMakeRange(0, kBufferLength)];
    // 转成富文本
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:buffer];
    buffer = nil; // 马上释放
    // 设置富文本属性
    JJTxtReaderManager *manager = [JJTxtReaderManager sharedTxtReaderManager];
    [attrString setAttributes:manager.attributes range:NSMakeRange(0, attrString.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attrString);
    CGPathRef path = CGPathCreateWithRect(CGRectMake(0, 0, [manager eachPageSize].width, [manager eachPageSize].height), NULL);
    
    int currentOffset = 0; // 文档中的偏移量
    int currentInnerOffset = 0; // 缓存文档中的偏移量
    BOOL hasMorePages = YES;
    
    [self.locations removeAllObjects];
    // 防止死循环，如果在同一个位置获取CTFrame超过2次，则跳出循环
//    int preventDeadLoopSign = currentOffset; // 当前偏移量
//    int samePlaceRepeatCount = 0; // 相同位置重复次数
    
    while (hasMorePages)
    {
//        if (preventDeadLoopSign == currentOffset) { // 第一次肯定相等
//            
//            ++samePlaceRepeatCount;
//            
//        } else {
//            
//            samePlaceRepeatCount = 0;
//        }

        [self.locations addObject:@(currentOffset)];
//        _pageOffsets.push_back(currentOffset);
        // 第一次从0，0开始计算----第二次上次length开始 If the length portion of the range is set to 0, then the framesetter continues to add lines until it runs out of text or space.
        CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(currentInnerOffset, 0), path, NULL);
        CFRange range = CTFrameGetVisibleStringRange(frame); // 获取可见字符串range---第二次获取
        CFRange ran = CFRangeMake(currentInnerOffset, 0);
        NSLog(@"%ld === %ld", ran.location, ran.length);
        //        CTFramesetterSuggestFrameSizeWithConstraints(<#CTFramesetterRef  _Nonnull framesetter#>, <#CFRange stringRange#>, <#CFDictionaryRef  _Nullable frameAttributes#>, <#CGSize constraints#>, <#CFRange * _Nullable fitRange#>)
        
        if ((range.location + range.length) != attrString.length)
        { // 在指定区域截取的字符串和预设的字符串长度不一致
            
            currentOffset += range.length; // 累加长度
            currentInnerOffset += range.length;
            
        }
        // 预设的字符串截取完,最后剩余的字符串也能显示完，但屏幕未占满，重新获取
        else if ((range.location + range.length) == attrString.length && (currentOffset + range.length) != [self.txt length])
        {
            // 加载后面的
            CFRelease(frame); frame = NULL;
            CFRelease(frameSetter);
            
            [self.locations removeLastObject];
//            _pageOffsets.pop_back();
            // 从当前位置重新截取预设区域字符串（从当前位置重复上次操作）
            buffer = [self stringWithRange:NSMakeRange(currentOffset, kBufferLength)];
            attrString = [[NSMutableAttributedString alloc] initWithString:buffer];
            [attrString setAttributes:manager.attributes range:NSMakeRange(0, attrString.length)];
            buffer = nil;
            
            currentInnerOffset = 0;
            
            frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attrString);
        }
        else // 文档截取完
        {
            // 已经分完，提示跳出循环
            hasMorePages = NO;
        }
        if (frame) CFRelease(frame);
    }
    
    
    
    
    
    
    
    CGPathRelease(path);
    CFRelease(frameSetter);
    
    !_completion ? :_completion(YES, self);

}
/**
 *  获取指定range字符串
 */
- (NSString *)stringWithRange:(NSRange)range {
    
    NSUInteger location = range.location;
    NSUInteger length   = range.length;
    // range不合理，返回
    if (location == NSNotFound || location >= self.txt.length) return @"";
    
    NSUInteger loc_len = location + length;
    loc_len = loc_len > self.txt.length ? self.txt.length : loc_len; // 防止越界
    
    return [self.txt substringWithRange:NSMakeRange(location, loc_len - location)]; // 返回
}
/**
 *  获得page页的文字内容
 */
- (NSString *)stringOfPage:(NSUInteger)page {
    
    return [self.txt substringWithRange:[self rangeOfPage:page]];
}
/**
 *  根据当前的页码计算范围
 */
- (NSRange)rangeOfPage:(NSUInteger)page {
    if (!self.locations.count) return NSMakeRange(NSNotFound, 0);
    NSRange range;
    if (page > self.totalPage - 1) { // 总页数比实际页数少1，总页数从0开始的
        return NSMakeRange(NSNotFound, 0);
    } else if (page == self.totalPage - 1) {
        NSUInteger loc = [self.locations[page] integerValue]; // 最后一个节点
        NSUInteger length = self.txt.length; // 文档总长度
        range = NSMakeRange(loc, length - loc);
    } else {
        NSUInteger loc = [self.locations[page] integerValue]; // 获取节点
        NSUInteger nextLoc = [self.locations[page + 1] integerValue]; // 下一个节点
        range = NSMakeRange(loc, nextLoc - loc);
    }
    return range;
}
/**
 *  根据range获取相应的页码
 */
- (NSUInteger)pageOfRange:(NSRange)range {
    
    __block NSUInteger page;
    [self.locations enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSUInteger loc = [obj integerValue]; // 页数的下标
        if (range.location < loc) {
            page = idx - 1;
            *stop = YES;
        } else if (range.location == loc) {
            page = idx;
            *stop = YES;
        }
    }];
    return page;
}

/**
 *  根据页数获取所得章节模型
 */
- (JJChapterModel *)chapterOfPage:(NSUInteger)page {
    
    if (!self.chapters.count) return nil;
    
    if (page > self.totalPage - 1) return nil;
    __block NSUInteger index = self.chapters.count - 1;
//    if (index < 0) return nil;
    
    NSRange range = [self rangeOfPage:page];
    [self.chapters enumerateObjectsUsingBlock:^(JJChapterModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSLog(@"%lu --- %lu", (unsigned long)range.location , (unsigned long)obj.range.location);
        
        if (range.location <= obj.range.location) {
            index = idx;
            *stop = YES;
            
        }
//        else if (range.location > obj.range.location) {
//            
//        } else if (range.location < obj.range.location) {
//            index = idx - 1;
//            *stop = YES;
//            
//        }
    }];
    return self.chapters[index];
}











@end
