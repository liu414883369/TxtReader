//
//  UIView+JJ.h
//  读取txt文件
//
//  Created by liujianjian on 16/5/23.
//  Copyright © 2016年 rdg. All rights reserved.
//

#import <UIKit/UIKit.h>

CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (JJ)

@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

/// 高
@property CGFloat height;
/// 宽
@property CGFloat width;
/// Y坐标
@property CGFloat top;
/// X坐标
@property CGFloat left;
/// 底部 Y坐标+高度
@property CGFloat bottom;
/// 右侧 X坐标+宽度
@property CGFloat right;

- (void) moveBy: (CGPoint) delta;
- (void) scaleBy: (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;


/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)isShowingOnKeyWindow;

//- (CGFloat)x;
//- (void)setX:(CGFloat)x;
/** 在分类中声明@property, 只会生成方法的声明, 不会生成方法的实现和带有_下划线的成员变量*/

+ (instancetype)viewFromXib;

//- (void)setHidden:(BOOL)hidden;



@end
