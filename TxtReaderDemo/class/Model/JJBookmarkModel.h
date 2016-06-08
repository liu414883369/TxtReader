//
//  JJBookmarkModel.h
//  读取txt文件
//
//  Created by liujianjian on 16/6/2.
//  Copyright © 2016年 rdg. All rights reserved.
//  书签模型

#import <Foundation/Foundation.h>

@interface JJBookmarkModel : NSObject
/**
 *  存储时间
 */
@property (nonatomic, copy  ) NSString *storeTime;
/**
 *  存储的range
 */
@property (nonatomic, strong) NSNumber *range;
/**
 *  保存的部分内容
 */
@property (nonatomic, copy  ) NSString *partContent;



@end
