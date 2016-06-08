//
//  JJStoreTool.h
//  读取txt文件
//
//  Created by liujianjian on 16/6/8.
//  Copyright © 2016年 rdg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JJTxtAttribute.h"

@interface JJStoreTool : NSObject

/**
 *  归档
 */
+ (void)storeTxtAttribute:(JJTxtAttribute *)txtAttribute;

/**
 *  解档
 */
+ (JJTxtAttribute *)txtAttribute;

@end
