//
//  JJItemAttributes.h
//  读取txt文件
//
//  Created by LIUJIANJIAN on 16/5/22.
//  Copyright © 2016年 rdg. All rights reserved.
//  文件属性模型

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JJ_NSFileType) {
    JJ_NSFileTypeDirectory,
    JJ_NSFileTypeRegular,
};


@interface JJItemAttributes : NSObject

/// 文件类型
@property(nonatomic, assign)JJ_NSFileType fileType;
/// 文件大小 
@property(nonatomic, copy)NSString *fileSize;
/// 文件修改日期
@property(nonatomic, copy)NSString *fileModificationDate;
/// 文件名
@property(nonatomic, copy)NSString *fileName;
/// 文件路径
@property(nonatomic, copy)NSString *filePath;

/// 是否是隐藏文件
//@property(nonatomic, assign)BOOL isHiddenFile;



@end









