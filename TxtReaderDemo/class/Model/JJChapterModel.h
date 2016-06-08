//
//  JJCatalogModel.h
//  读取txt文件
//
//  Created by liujianjian on 16/5/25.
//  Copyright © 2016年 rdg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJChapterModel : NSObject
/**
 *  目录名
 */
@property (nonatomic, copy)NSString *title;
/**
 *  当前目录在文档中的位置
 */
//@property (nonatomic, copy)NSString *progress;
/**
 *  目录在文档中的range
 */
@property (nonatomic, assign)NSRange range;


@end
