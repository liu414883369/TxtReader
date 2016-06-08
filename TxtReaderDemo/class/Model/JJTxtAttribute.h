//
//  JJTxtAttribute.h
//  读取txt文件
//
//  Created by liujianjian on 16/5/31.
//  Copyright © 2016年 rdg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJTxtAttribute : NSObject<NSCoding>

/**
 *  字体大小
 */
@property (nonatomic, assign)CGFloat fontSize;
/**
 *  最小字体
 */
@property (nonatomic, assign)CGFloat minFontSize;
/**
 *  最大字体
 */
@property (nonatomic, assign)CGFloat maxFontSize;
/**
 *  行间距
 */
@property (nonatomic, assign)CGFloat textLineSpacing;
/**
 *  字体所在view控件的size
 */
@property (nonatomic, assign)CGSize textSize;
/**
 *  背景色
 */
@property (nonatomic, strong)UIColor *textBackgroundColor;
/**
 *  字体颜色
 */
@property (nonatomic, strong)UIColor *textColor;
/**
 *  当前页
 */
@property (nonatomic, assign)NSUInteger currentPage;
/**
 *  location（分割好的位置）
 */
@property (nonatomic, strong)NSArray *locations;
/**
 *  章节
 */
@property (nonatomic, strong)NSArray *chapters;


/**
 *  属性字典
 *
 *  @return 字体属性字典
 */
- (NSDictionary *)txtAttributes;

+ (instancetype)initTxtAttribute;



@end
