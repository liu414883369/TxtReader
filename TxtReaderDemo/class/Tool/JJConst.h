//
//  JJConst.h
//  读取txt文件
//
//  Created by liujianjian on 16/5/24.
//  Copyright © 2016年 rdg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+JJ.h"
#import "JJTxtReaderManager.h"
#import "SVProgressHUD.h"
#import "JJStoreTool.h"

/**
 *  屏幕宽
 */
static inline CGFloat screenWidth() {
    return [UIScreen mainScreen].bounds.size.width;
}
/**
 *  屏幕高
 */
static inline CGFloat screenHeight() {
    return [UIScreen mainScreen].bounds.size.height;
}

/**
 *  阅读器底部bar的高度
 */
UIKIT_EXTERN CGFloat const JJBottomBarH;
/**
 *  阅读器顶部bar的高度
 */
UIKIT_EXTERN CGFloat const JJTopBarH;
/**
 *  阅读器中间半圆形按钮宽
 */
UIKIT_EXTERN CGFloat const JJCenterBtnW;
/**
 *  阅读器中间半圆形按钮高
 */
UIKIT_EXTERN CGFloat const JJCenterBtnH;
/**
 *  移动隐藏动画时长
 */
UIKIT_EXTERN NSTimeInterval const JJMoveHiddenAnimationDuration;
/**
 *  阅读器最底下显示进度label的高
 */
UIKIT_EXTERN CGFloat const kProgressLabelH;



#pragma mark - 各种bar的高度
/**
 *  状态栏的高
 */
UIKIT_EXTERN CGFloat const kStatusBarH;
/**
 *  导航栏的高
 */
UIKIT_EXTERN CGFloat const kNavgationBarH;

#pragma mark - txt分割
/**
 *  文档分割每次取得字符串长度 50000
 */
UIKIT_EXTERN int const kBufferLength;



#pragma mark - ShowTxtView相关


/**
 *  距离屏幕左侧间隔
 */
UIKIT_EXTERN CGFloat const kShowTxtViewLeftGap;
/**
 *  顶部间隔
 */
UIKIT_EXTERN CGFloat const kShowTxtViewTopGap;
/**
 *  底部间隔
 */
UIKIT_EXTERN CGFloat const kShowTxtViewBottomGap;


#pragma mark - 翻页提示

/**
 *  翻到第一页提示
 */
UIKIT_EXTERN NSString* const kFirstPageHint;
/**
 *  翻到最后一页提示
 */
UIKIT_EXTERN NSString* const kLastPageHint;
/**
 *  文档解析提示...
 */
UIKIT_EXTERN NSString* const kTxtParseHint;

/**
 *  最小字体
 */
UIKIT_EXTERN CGFloat const minFontSize;

/**
 *  最大字体
 */
UIKIT_EXTERN CGFloat const maxFontSize;
/**
 *  默认字体
 */
UIKIT_EXTERN CGFloat const defaultFontSize;







