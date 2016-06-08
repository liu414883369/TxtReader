//
//  JJBottomBar.h
//  读取txt文件
//
//  Created by liujianjian on 16/5/23.
//  Copyright © 2016年 rdg. All rights reserved.
//  底部的bar

#import <UIKit/UIKit.h>
#import "JJMoveHiddenProtocol.h"

typedef void(^JJBottomBarValueEndChangedBlock)(CGFloat);

@interface JJBottomBar : UIView<JJBarMoveHiddenProtocol>
/**
 *  进度
 */
@property (nonatomic, assign)CGFloat currentPage;
/**
 *  手指离开slider时调用
 */
@property (nonatomic, copy)JJBottomBarValueEndChangedBlock valueEndChanged;

@property(nonatomic, assign) CGFloat minimumValue;
@property(nonatomic, assign) CGFloat maximumValue;

@end
