//
//  JJMoreActionView.m
//  读取txt文件
//
//  Created by liujianjian on 16/6/2.
//  Copyright © 2016年 rdg. All rights reserved.
//

#import "JJMoreActionView.h"
#import "JJSlider.h"
#import "JJConst.h"
#import "DTColorPickerImageView.h"

typedef enum : NSUInteger {
    JJMoreActionViewBackgroundColor,
    JJMoreActionViewTextColor,
} JJMoreActionViewColorType;

@interface JJMoreActionView()<DTColorPickerImageViewDelegate>
{
    UIButton *_tempBtn;
}
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet JJSlider *ligthSlider;
@property (strong, nonatomic) IBOutlet JJSlider *fontSlider;
@property (strong, nonatomic) IBOutlet UIButton *searchBtn;
@property (strong, nonatomic) IBOutlet UIButton *switchBtn;
@property (strong, nonatomic) IBOutlet UIButton *backgroundBtn;
@property (strong, nonatomic) IBOutlet UIButton *textColorBtn;
@property (strong, nonatomic) IBOutlet DTColorPickerImageView *colView;
@property (nonatomic, assign)JJMoreActionViewColorType type;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *colorHeight;

@end

@implementation JJMoreActionView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.backgroundColor = [UIColor colorWithRed:36.0/255.0 green:36.0/255.0 blue:36.0/255.0 alpha:1];
    
    self.fontSlider.minimumValue = minFontSize;
    self.fontSlider.maximumValue = maxFontSize;
    self.fontSlider.value = [JJTxtReaderManager sharedTxtReaderManager].txtAttribute.fontSize;
    
    self.ligthSlider.minimumValue = 0;
    self.ligthSlider.maximumValue = 1;
    self.ligthSlider.value = [UIScreen mainScreen].brightness;
    
    self.backgroundBtn.layer.cornerRadius = 15.0;
    self.backgroundBtn.layer.masksToBounds = YES;
    
    self.textColorBtn.layer.cornerRadius = 15.0;
    self.textColorBtn.layer.masksToBounds = YES;
    
    self.colView.delegate = self;
}
/**
 *  搜索
 */
- (IBAction)search:(id)sender {
    [self hideColorView];
    if ([self.delegate respondsToSelector:@selector(moreActionView:search:)]) {
        [self.delegate moreActionView:self search:self.searchBtn];
    }
}
/**
 *  夜间模式
 */
- (IBAction)switchLight:(UIButton *)sender {
    [self hideColorView];
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(moreActionView:switch:)]) {
        [self.delegate moreActionView:self switch:sender];
    }
}
/**
 *  滑动中手指离开slider，抬起手指后事件(字体)
 */
- (IBAction)sliderTouchUpOutside:(JJSlider *)sender {
    [self hideColorView];
    if ([self.delegate respondsToSelector:@selector(moreActionView:fontSlider:)]) {
        [self.delegate moreActionView:self fontSlider:sender];
    }
}
/**
 *  滑动中手指从slider上抬起事件(字体)
 */
- (IBAction)sliderTouchUpInside:(JJSlider *)sender {
    [self hideColorView];
    if ([self.delegate respondsToSelector:@selector(moreActionView:fontSlider:)]) {
        [self.delegate moreActionView:self fontSlider:sender];
    }
}
/**
 *  手指持续滑动回调(字体)
 */
- (IBAction)progressSliderValueChanged:(JJSlider *)sender {
    [self hideColorView];
}
/**
 *  亮度调整
 */
- (IBAction)lightSliderValueChanged:(JJSlider *)sender {
    [self hideColorView];
    [UIScreen mainScreen].brightness = sender.value;
}

#pragma mark - DTColorPickerImageViewDelegate

- (void)imageView:(UIImage *)imageView didPickColorWithColor:(UIColor *)color {
    switch (self.type) {
        case JJMoreActionViewTextColor:
        {
            if ([self.delegate respondsToSelector:@selector(moreActionView:textColor:)]) {
                [self.delegate moreActionView:self textColor:color];
            }
        }
            break;
        case JJMoreActionViewBackgroundColor:
        {
            if ([self.delegate respondsToSelector:@selector(moreActionView:backgroundColor:)]) {
                [self.delegate moreActionView:self backgroundColor:color];
            }
        }
            break;
        default:
            break;
    }
}
/**
 *  背景色
 */
- (IBAction)backgroundColor:(UIButton *)sender {
    _tempBtn.selected = !_tempBtn.selected;
    _tempBtn = sender;
    _tempBtn.selected = !_tempBtn.selected;
    
    self.type = JJMoreActionViewBackgroundColor;
    [self showColorView];
}
/**
 *  文字颜色
 */
- (IBAction)textColor:(UIButton *)sender {
    
    _tempBtn.selected = !_tempBtn.selected;
    _tempBtn = sender;
    _tempBtn.selected = !_tempBtn.selected;
    
    _tempBtn = sender;
    self.type = JJMoreActionViewTextColor;
    [self showColorView];
}

- (void)showColorView {
    [UIView animateWithDuration:0.25 animations:^{
        self.colorHeight.constant = 260.0;
    }];
    [self layoutIfNeeded];
}
- (void)hideColorView {
    _tempBtn.selected = NO;
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.25 animations:^{
        self.colorHeight.constant = 0.0;
    }];
    
}










@end
