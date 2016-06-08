//
//  JJMoveHiddenProtocol.h
//  读取txt文件
//
//  Created by liujianjian on 16/5/24.
//  Copyright © 2016年 rdg. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JJBarMoveHiddenProtocol <NSObject>

@required
/**
 *  移动隐藏
 */
- (void)moveHidden;
/**
 *  移动显示
 */
- (void)moveShow;


@end
