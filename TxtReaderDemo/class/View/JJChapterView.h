//
//  JJChaptersView.h
//  读取txt文件
//
//  Created by liujianjian on 16/5/25.
//  Copyright © 2016年 rdg. All rights reserved.
//  章节和书签

#import "JJMaskView.h"

typedef NS_ENUM(NSUInteger, TableViewShowType) {
    TableViewShowChapters = 0, // 显示目录
    TableViewShowBookmark, // 书签
};

@protocol JJChapterViewDelegate;
@interface JJChapterView : JJMaskView

@property (nonatomic, strong)NSArray *dataSource;

@property (nonatomic, assign)id<JJChapterViewDelegate> delegate;

@property (nonatomic, assign)NSUInteger currentPage;


@end

@protocol JJChapterViewDelegate <NSObject>

- (void)chapterView:(JJChapterView *)view type:(TableViewShowType)type indexPath:(NSIndexPath *)indexPath;

@end
