//
//  NSString+JJ_Extension.h
//  读取txt文件
//
//  Created by LIUJIANJIAN on 16/5/22.
//  Copyright © 2016年 rdg. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JJItemAttributes;

@interface NSString (JJ_Extension)

/// 获取某路径下所有文件属性
- (NSArray<JJItemAttributes *> *)itemAttributes;

@end
