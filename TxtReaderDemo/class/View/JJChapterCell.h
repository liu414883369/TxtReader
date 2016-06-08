//
//  JJChapterCell.h
//  读取txt文件
//
//  Created by liujianjian on 16/6/2.
//  Copyright © 2016年 rdg. All rights reserved.
//  章节cell

#import <UIKit/UIKit.h>

@interface JJChapterCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *readView;

- (void)loadWithData:(id)data;

@end
