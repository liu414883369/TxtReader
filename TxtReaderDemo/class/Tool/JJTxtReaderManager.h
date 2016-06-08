//
//  JJTxtReaderManager.h
//  读取txt文件
//
//  Created by liujianjian on 16/5/31.
//  Copyright © 2016年 rdg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJTxtParse.h" // 解析类
#import "JJTxtAttribute.h" // 文档属性

@class JJChapterModel;
@class JJBookmarkModel;

typedef void(^ParseCompletion)(BOOL);

@interface JJTxtReaderManager : NSObject
/**
 *  解析类
 */
@property (nonatomic, strong)JJTxtParse *txtParse;
/**
 *  字体属性类
 */
@property (nonatomic, strong)JJTxtAttribute *txtAttribute;

/**
 *  初始化单例
 *
 *  @return self
 */
+ (JJTxtReaderManager *)sharedTxtReaderManager;
/**
 *  文档解析
 *
 *  @param path       文档路径
 *  @param completion 完成后回调
 *  @param queue      解析线程
 */
- (void)parseWithPath:(NSString *)path completion:(ParseCompletion)completion onQueue:(dispatch_queue_t)queue;
/**
 *  字体属性字典
 */
- (NSDictionary *)attributes;

/**
 *  一个屏幕中显示文字框的大小
 */
- (CGSize)eachPageSize;
/**
 *  txt文档
 */
- (NSString *)txt;
/**
 *  当前页
 */
- (NSUInteger)currentPage;
/**
 *  总页
 */
- (NSUInteger)totalPage;
/**
 *  根据页码返回字符串
 */
- (NSString *)stringOfPage:(NSUInteger)page;
/**
 *  根据range获取相应的页码
 */
- (NSUInteger)pageOfRange:(NSRange)range;
/**
 *  章节目录
 */
- (NSArray <JJChapterModel *> *)chapters;

/**
 *  书签数组
 */
- (NSArray <JJBookmarkModel *> *)bookmarks;
/**
 *  根据页数获取所得章节模型
 */
- (JJChapterModel *)chapterOfPage:(NSUInteger)page;




@end
