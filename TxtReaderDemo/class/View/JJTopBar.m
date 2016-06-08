//
//  JJTopBar.m
//  读取txt文件
//
//  Created by liujianjian on 16/5/24.
//  Copyright © 2016年 rdg. All rights reserved.
//

#import "JJTopBar.h"
#import "JJConst.h"

@implementation JJTopBar

- (IBAction)backBtnClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(back)]) {
        [self.delegate back];
    }
}
- (IBAction)moreBtnClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(more)]) {
        [self.delegate more];
    }
}
- (IBAction)bookmarkBtnClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(bookmark)]) {
        [self.delegate bookmark];
    }
}

#pragma mark - JJMoveHiddenProtocol

- (void)moveHidden {
    [UIView animateWithDuration:JJMoveHiddenAnimationDuration animations:^{
        self.transform = CGAffineTransformMakeTranslation(0.0, 0.0 - JJTopBarH);
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
