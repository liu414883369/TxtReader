//
//  JJCenterBtn.m
//  读取txt文件
//
//  Created by liujianjian on 16/5/24.
//  Copyright © 2016年 rdg. All rights reserved.
//

#import "JJCenterBtn.h"
#import "JJConst.h"

@implementation JJCenterBtn

#pragma mark - JJMoveHiddenProtocol

- (void)moveHidden {
    [UIView animateWithDuration:JJMoveHiddenAnimationDuration animations:^{
        self.transform = CGAffineTransformMakeTranslation(0.0 - JJCenterBtnW, 0);
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


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed:@"app_tr_toolbar_l_btn"];
    [image drawInRect:rect];
}


@end
