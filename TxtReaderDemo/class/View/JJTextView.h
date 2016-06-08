//
//  JJTextView.h
//  读取txt文件
//
//  Created by liujianjian on 16/5/25.
//  Copyright  © 2016年 rdg. All rights reserved.
//  获取当前屏幕上可见的文字

#import <UIKit/UIKit.h>

@interface JJTextView : UITextView

@property (nonatomic, strong)NSString *txtLocalPath;
- (NSRange)visibleRangeConsideringInsets:(BOOL)considerInsets startPosition:(UITextPosition *__autoreleasing *)startPosition endPosition:(UITextPosition *__autoreleasing *)endPosition;
@end
