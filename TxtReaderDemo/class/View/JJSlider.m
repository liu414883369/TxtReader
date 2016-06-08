//
//  JJSlider.m
//  读取txt文件
//
//  Created by liujianjian on 16/6/3.
//  Copyright © 2016年 rdg. All rights reserved.
//

#import "JJSlider.h"
#import "JJConst.h"

@implementation JJSlider

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    // 滑块
    UIImage *thumbImage = [UIImage imageNamed:@"app_bp_slider_dot"];
    // 左侧图片
    UIImage *minimumTrackImage = [UIImage imageNamed:@"app_bp_slider_line_on"];
    minimumTrackImage = [minimumTrackImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    // 右侧图片
    UIImage *MaximumTrackImage = [UIImage imageNamed:@"app_bp_slider_line_off"];
    MaximumTrackImage = [MaximumTrackImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    // 添加滑块等...
    [self setThumbImage:thumbImage forState:UIControlStateNormal];
    [self setMinimumTrackImage:minimumTrackImage forState:UIControlStateNormal];
    [self setMaximumTrackImage:MaximumTrackImage forState:UIControlStateNormal];
    
}
//- (void)awakeFromNib {
//    self.minimumValue = minFontSize;
//    self.maximumValue = maxFontSize;
//    self.value = [JJTxtReaderManager sharedTxtReaderManager].txtAttribute.fontSize;
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
