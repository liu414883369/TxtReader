//
//  JJMaskView.h
//  WeiZhiUser
//
//  Created by weizhi on 14/11/7.
//  Copyright (c) 2014年  Ren. All rights reserved.
//  半透明view

#import <UIKit/UIKit.h>

typedef void(^JJMaskViewDismissBlock)();
/**
 *  动画方向
 */
typedef NS_ENUM(NSInteger, JJMaskViewAnimationOrientation){
    /**
     *  从底部弹出
     */
    JJMaskViewAnimationBottom = 0,
    /**
     *  从上部弹出
     */
    JJMaskViewAnimationTop,
    /**
     *  从左部弹出
     */
    JJMaskViewAnimationLeft,
    /**
     *  从右部弹出
     */
    JJMaskViewAnimationRight,
};

@interface JJMaskView : UIView<UIGestureRecognizerDelegate>
/**
 *  动画弹出方向
 */
@property (nonatomic, assign)JJMaskViewAnimationOrientation animationOrientation;
/**
 *  界面移除后回调
 */
@property (nonatomic, copy)JJMaskViewDismissBlock dismissBlock;

/**
 *  开始动画（不调用没有动画效果）
 */
- (void)animationStart;

/**
 *  移除
 */
- (void)dismiss;






@end
