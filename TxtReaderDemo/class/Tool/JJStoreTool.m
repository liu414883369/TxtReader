//
//  JJStoreTool.m
//  读取txt文件
//
//  Created by liujianjian on 16/6/8.
//  Copyright © 2016年 rdg. All rights reserved.
//

#import "JJStoreTool.h"

#define kTxtAttribute [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"txtAttribute.data"]

@implementation JJStoreTool

/**
 *  归档
 */
+ (void)storeTxtAttribute:(JJTxtAttribute *)txtAttribute {
    
    [NSKeyedArchiver archiveRootObject:txtAttribute toFile:kTxtAttribute];
    
}
/**
 *  解档
 */
+ (JJTxtAttribute *)txtAttribute {
    
    JJTxtAttribute *txtAttribute = [NSKeyedUnarchiver unarchiveObjectWithFile:kTxtAttribute];
    return txtAttribute;
    
}

@end
