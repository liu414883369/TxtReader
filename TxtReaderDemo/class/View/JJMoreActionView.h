//
//  JJMoreActionView.h
//  读取txt文件
//
//  Created by liujianjian on 16/6/2.
//  Copyright © 2016年 rdg. All rights reserved.
//  更多view

#import "JJMaskView.h"
#import "JJSlider.h"

@protocol JJMoreActionViewDelegate;

@interface JJMoreActionView : JJMaskView
@property (nonatomic, assign)id<JJMoreActionViewDelegate> delegate;

@end


@protocol JJMoreActionViewDelegate <NSObject>
@optional
/**
 *  亮度调节
 */
- (void)moreActionView:(JJMoreActionView *)view lightSlider:(JJSlider *)slider;
/**
 *  字体调节
 */
- (void)moreActionView:(JJMoreActionView *)view fontSlider:(JJSlider *)slider;
/**
 *  搜索关键字
 */
- (void)moreActionView:(JJMoreActionView *)view search:(UIButton *)btn;
/**
 *  夜间模式
 */
- (void)moreActionView:(JJMoreActionView *)view switch:(UIButton *)btn;
/**
 *  字体颜色
 */
- (void)moreActionView:(JJMoreActionView *)view textColor:(UIColor *)textColor;
/**
 *  背景色
 */
- (void)moreActionView:(JJMoreActionView *)view backgroundColor:(UIColor *)backgroundColor;


@end