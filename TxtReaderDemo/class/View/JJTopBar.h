//
//  JJTopBar.h
//  读取txt文件
//
//  Created by liujianjian on 16/5/24.
//  Copyright © 2016年 rdg. All rights reserved.
//  顶部bar

#import <UIKit/UIKit.h>
#import "JJMoveHiddenProtocol.h"

@protocol JJTopBarDelegate;

@interface JJTopBar : UIView<JJBarMoveHiddenProtocol>
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign)id<JJTopBarDelegate> delegate;

@end

@protocol JJTopBarDelegate <NSObject>

@optional
/**
 *  返回
 */
- (void)back;
/**
 *  书签
 */
- (void)bookmark;
/**
 *  更多
 */
- (void)more;

@end