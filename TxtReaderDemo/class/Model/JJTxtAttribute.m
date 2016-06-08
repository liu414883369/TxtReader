//
//  JJTxtAttribute.m
//  读取txt文件
//
//  Created by liujianjian on 16/5/31.
//  Copyright © 2016年 rdg. All rights reserved.
//  文档的属性

#import "JJTxtAttribute.h"
#import "JJConst.h"

@implementation JJTxtAttribute

+ (instancetype)initTxtAttribute {
    JJTxtAttribute *txtAttribute = [JJStoreTool txtAttribute];
    if (txtAttribute) {
        return txtAttribute;
    } else {
        return [[self alloc] init];
    }
}


#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeDouble:self.fontSize forKey:@"fontSize"];
    [aCoder encodeObject:self.textBackgroundColor forKey:@"textBackgroundColor"];
    [aCoder encodeObject:self.textColor forKey:@"textColor"];
    [aCoder encodeInteger:self.currentPage forKey:@"currentPage"];
    [aCoder encodeObject:self.locations forKey:@"locations"];
    [aCoder encodeObject:self.chapters forKey:@"chapters"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self.fontSize = [aDecoder decodeDoubleForKey:@"fontSize"];
    self.textBackgroundColor = [aDecoder decodeObjectForKey:@"textBackgroundColor"];
    self.textColor = [aDecoder decodeObjectForKey:@"textColor"];
    self.currentPage = [aDecoder decodeIntegerForKey:@"currentPage"];
    self.locations = [aDecoder decodeObjectForKey:@"locations"];
    self.chapters = [aDecoder decodeObjectForKey:@"chapters"];
    
    return self;
}

- (CGFloat)fontSize {
    if (!_fontSize) {
        _fontSize = defaultFontSize;
    }
    return _fontSize;
}
- (CGFloat)minFontSize {
    if (!_minFontSize) {
        _minFontSize = minFontSize;
    }
    return _minFontSize;
}
- (CGFloat)maxFontSize {
    if (!_maxFontSize) {
        _maxFontSize = maxFontSize;
    }
    return _maxFontSize;
}
- (CGFloat)textLineSpacing {
    if (!_textLineSpacing) {
        _textLineSpacing = self.fontSize / 2.0;
    }
    return _textLineSpacing;
}
- (CGSize)textSize {
    if (!_textSize.width || !_textSize.height) {
        _textSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - kShowTxtViewLeftGap * 2.0,
                               [UIScreen mainScreen].bounds.size.height - kShowTxtViewTopGap - kShowTxtViewBottomGap);
    }
    return _textSize;
}
- (UIColor *)textBackgroundColor {
    if (!_textBackgroundColor) {
        _textBackgroundColor = [UIColor whiteColor];
    }
    return _textBackgroundColor;
}
- (UIColor *)textColor {
    if (!_textColor) {
        _textColor = [UIColor blackColor];
    }
    return _textColor;
}
- (NSUInteger)currentPage {
    if (!_currentPage) {
        _currentPage = 0;
    }
    return _currentPage;
}

- (NSDictionary *)txtAttributes
{
    UIFont *font = [UIFont systemFontOfSize:self.fontSize]; // 字号
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = self.textLineSpacing; // 行间距
    paragraphStyle.alignment = NSTextAlignmentJustified; // //最后一行自然对齐
    
    UIColor *textColor = self.textColor; // 字体颜色
    
    return @{NSParagraphStyleAttributeName: paragraphStyle,
             NSFontAttributeName:font,
             NSForegroundColorAttributeName:textColor};
}



@end
