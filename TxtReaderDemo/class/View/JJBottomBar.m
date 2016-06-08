//
//  JJBottomBar.m
//  读取txt文件
//
//  Created by liujianjian on 16/5/23.
//  Copyright © 2016年 rdg. All rights reserved.
//

#import "JJBottomBar.h"
#import "JJConst.h"

@interface JJBottomBar()
@property (strong, nonatomic) IBOutlet UILabel *progressLabel;
@property (strong, nonatomic) IBOutlet UISlider *progressSlider;

@end

@implementation JJBottomBar
/**
 *  滑动中手指离开slider，抬起手指后事件
 */
- (IBAction)sliderTouchUpOutside:(UISlider *)sender {
    !_valueEndChanged ? : _valueEndChanged(sender.value);
}
/**
 *  滑动中手指从slider上抬起事件
 */
- (IBAction)sliderTouchUpInside:(UISlider *)sender {
    !_valueEndChanged ? : _valueEndChanged(sender.value);
}
/**
 *  手指持续滑动回调
 */
- (IBAction)progressSliderValueChanged:(UISlider *)sender {
    
    self.progressLabel.text = [NSString stringWithFormat:@"%.1f%%", sender.value / self.maximumValue * 100];
}

#pragma mark - setter
- (void)setCurrentPage:(CGFloat)currentPage {
    _currentPage = currentPage;
    self.progressLabel.text = [NSString stringWithFormat:@"%.1f%%", currentPage / self.maximumValue * 100.0];
    self.progressSlider.value = currentPage;
}

- (void)setMinimumValue:(CGFloat)minimumValue {
    _minimumValue = minimumValue;
    self.progressSlider.minimumValue = minimumValue;
}

- (void)setMaximumValue:(CGFloat)maximumValue {
    _maximumValue = maximumValue;
    self.progressSlider.maximumValue = maximumValue;
}
#pragma mark - JJMoveHiddenProtocol

- (void)moveHidden {
    [UIView animateWithDuration:JJMoveHiddenAnimationDuration animations:^{
        self.transform = CGAffineTransformMakeTranslation(0.0, screenHeight());
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}
- (void)moveShow {
    self.hidden = NO;
    [UIView animateWithDuration:JJMoveHiddenAnimationDuration animations:^{
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
//        self.hidden = YES;
    }];
}

@end
