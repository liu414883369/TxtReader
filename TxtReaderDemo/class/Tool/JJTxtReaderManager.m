//
//  JJTxtReaderManager.m
//  读取txt文件
//
//  Created by liujianjian on 16/5/31.
//  Copyright © 2016年 rdg. All rights reserved.
//

#import "JJTxtReaderManager.h"

@interface JJTxtReaderManager()



@end

@implementation JJTxtReaderManager

- (NSDictionary *)attributes {
    return self.txtAttribute.txtAttributes;
}
- (CGSize)eachPageSize {
    return self.txtAttribute.textSize;
}

- (void)parseWithPath:(NSString *)path completion:(ParseCompletion)completion onQueue:(dispatch_queue_t)queue {
    [self.txtParse startParseWithPath:path completion:^(BOOL complete, JJTxtParse *txtParse) {
        completion(complete);
    } onQueue:queue];
}
- (NSString *)txt {
    return self.txtParse.txt;
}
- (NSUInteger)currentPage {
    return self.txtAttribute.currentPage;
}
- (NSUInteger)totalPage {
    return self.txtParse.totalPage;
}
- (NSString *)stringOfPage:(NSUInteger)page {
    return [self.txtParse stringOfPage:page];
}
- (NSUInteger)pageOfRange:(NSRange)range {
    return [self.txtParse pageOfRange:range];
}
- (NSArray <JJChapterModel *> *)chapters {
    return self.txtParse.chapters;
}
- (NSArray <JJBookmarkModel *> *)bookmarks {
    return nil;
}
- (JJChapterModel *)chapterOfPage:(NSUInteger)page {
    return [self.txtParse chapterOfPage:page];
}

#pragma mark - init

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.txtParse = [[JJTxtParse alloc] init];
//        self.txtAttribute = [[JJTxtAttribute alloc] init];
        self.txtAttribute = [JJTxtAttribute initTxtAttribute];
    }
    return self;
}

static id _instance;
// 这里使用的是ARC下的单例模式
+ (JJTxtReaderManager *)sharedTxtReaderManager {
    // dispatch_once不仅意味着代码仅会被运行一次，而且还是线程安全的
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}
+ (id)allocWithZone:(NSZone *)zone {
    // dispatch_once不仅意味着代码仅会被运行一次，而且还是线程安全的
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
+ (id)copyWithZone:(struct _NSZone *)zone {
    return _instance;
}

@end
