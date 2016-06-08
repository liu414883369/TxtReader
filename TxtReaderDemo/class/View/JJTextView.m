//
//  JJTextView.m
//  读取txt文件
//
//  Created by liujianjian on 16/5/25.
//  Copyright © 2016年 rdg. All rights reserved.
//

#import "JJTextView.h"


@interface JJTextView()

@end

@implementation JJTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setTxtLocalPath:(NSString *)txtLocalPath {
    _txtLocalPath = txtLocalPath;
    
}

// 解析目录
- (void)parseCatalog {
//    self scrollRectToVisible:<#(CGRect)#> animated:<#(BOOL)#>
}
//- (NSString *)progressInTxt:()
// 获取当前屏幕上可见的文字
- (NSRange)visibleRangeConsideringInsets:(BOOL)considerInsets startPosition:(UITextPosition *__autoreleasing *)startPosition endPosition:(UITextPosition *__autoreleasing *)endPosition
{
    CGRect visibleRect = [self visibleRectConsideringInsets:considerInsets];
    CGPoint startPoint = visibleRect.origin;
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(visibleRect), CGRectGetMaxY(visibleRect));
    
    UITextPosition *start = [self closestPositionToPoint:startPoint];
    UITextPosition *end = [self closestPositionToPoint:endPoint];
    
    if (startPosition)
        *startPosition = start;
    if (endPosition)
        *endPosition = end;
    // 返回两个UITextPosition之间的字符个数
    NSInteger startX = [self offsetFromPosition:self.beginningOfDocument toPosition:start];
    NSInteger length = [self offsetFromPosition:start toPosition:end];
    return NSMakeRange(startX, length);
}

// Returns visible rect, eventually considering insets
- (CGRect)visibleRectConsideringInsets:(BOOL)considerInsets
{
    CGRect bounds = self.bounds;
    if (considerInsets)
    {
        UIEdgeInsets contentInset = self.contentInset;
        CGRect visibleRect = self.bounds;
        visibleRect.origin.x += contentInset.left;
        visibleRect.origin.y += contentInset.top;
        visibleRect.size.width -= (contentInset.left + contentInset.right);
        visibleRect.size.height -= (contentInset.top + contentInset.bottom);
        return visibleRect;
    }
    return bounds;
}









@end
