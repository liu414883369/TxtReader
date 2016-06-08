//
//  JJTxtParse.h
//  读取txt文件
//
//  Created by liujianjian on 16/5/30.
//  Copyright © 2016年 rdg. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JJTxtParse;
@class JJChapterModel;

typedef void(^completeBlock)(BOOL, JJTxtParse *);

@interface JJTxtParse : NSObject
/**
 *  txt文件路径
 */
@property (nonatomic, strong)NSString *txtPath;
/**
 *  总页数
 */
@property (nonatomic, assign, readonly)NSUInteger totalPage;
/**
 *  章节数组模型
 */
@property (nonatomic, strong)NSMutableArray<JJChapterModel *> *chapters;

/**
 *  总文本
 */
@property (nonatomic, strong)NSString *txt;

/**
 *  获取range间字符串
 */
- (NSString *)stringWithRange:(NSRange)range;
/**
 *  获得page页的文字字符串
 */
- (NSString *)stringOfPage:(NSUInteger)page;
/**
 *  根据当前的页码计算范围
 */
- (NSRange)rangeOfPage:(NSUInteger)page;
/**
 *  根据range获取相应的页码
 */
- (NSUInteger)pageOfRange:(NSRange)range;
/**
 *  根据页数获取所得章节模型
 */
- (JJChapterModel *)chapterOfPage:(NSUInteger)page;

/**
 *  文档解析
 */
- (void)startParseWithPath:(NSString *)path completion:(completeBlock)completion onQueue:(dispatch_queue_t)queue;


@end






