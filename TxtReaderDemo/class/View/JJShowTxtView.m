//
//  JJShowTxtView.m
//  读取txt文件
//
//  Created by liujianjian on 16/5/30.
//  Copyright © 2016年 rdg. All rights reserved.
//

#import "JJShowTxtView.h"
#import <CoreText/CoreText.h>
#import "JJTxtReaderManager.h"

@implementation JJShowTxtView

- (void)drawRect:(CGRect)rect {
 
    [super drawRect:rect];
    
    if (!self.text.length) return;
    
    // 步骤1：得到当前用于绘制画布的上下文，用于后续将内容绘制在画布上
    // 因为Core Text要配合Core Graphic 配合使用的，如Core Graphic一样，绘图的时候需要获得当前的上下文进行绘制
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 步骤2：翻转当前的坐标系（因为对于底层绘制引擎来说，屏幕左下角为（0，0））
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // 步骤3：创建绘制区域
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    
    // 步骤4：创建需要绘制的文字与计算需要绘制的区域
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self.text];
    [attrString setAttributes:[JJTxtReaderManager sharedTxtReaderManager].attributes range:NSMakeRange(0, attrString.length)];
    // 步骤5：根据AttributedString生成CTFramesetterRef
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrString);
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, [attrString length]), path, NULL);
    
    // 步骤6：进行绘制
    CTFrameDraw(frame, context);
    attrString = nil;
    // 步骤7.内存管理
    CFRelease(frame);
    CFRelease(path);
    CFRelease(frameSetter);
    
}
 
/**
 *  根据font返回属性字典
 */
//- (NSDictionary *)attributes
//{
//    UIFont *font = [UIFont systemFontOfSize:16.0];
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle.lineSpacing = font.pointSize / 2; // 行间距
//    paragraphStyle.alignment = NSTextAlignmentJustified; // //最后一行自然对齐
//    return @{NSParagraphStyleAttributeName: paragraphStyle, NSFontAttributeName:font};
//}

@end
