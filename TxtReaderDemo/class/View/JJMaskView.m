//
//  JJMaskView.m
//  WeiZhiUser
//
//  Created by weizhi on 14/11/7.
//  Copyright (c) 2014年  Ren. All rights reserved.
//

#import "JJMaskView.h"

#define k_Animate_Duration 0.3
#define k_JJMaskView_Alpha 0.3
#define Scree_Height ([UIScreen mainScreen].bounds.size.height)
#define Scree_Width ([UIScreen mainScreen].bounds.size.width)

@interface JJMaskView ()
/**
 *  初始X坐标
 */
@property(nonatomic, assign)CGFloat siteX;
/**
 *  初始Y坐标
 */
@property(nonatomic, assign)CGFloat siteY;
/**
 *  frame
 */
//@property (nonatomic, assign)CGRect jj_frame;


@end

@implementation JJMaskView

//- (instancetype)initWithCoder:(NSCoder *)coder
//{
//    self = [super initWithCoder:coder];
//    if (self) {
//        self.siteX = 0.0;
//        self.siteY = Scree_Height;
//        [self makeSubviews];
//    }
//    return self;
//}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.siteX = 0.0;
//        self.siteY = Scree_Height;
//        self.jj_frame = frame;
        [self makeSubviews];
    }
    return self;
}
- (void)awakeFromNib {
    self.siteX = 0.0;
    self.siteY = Scree_Height;
    [self makeSubviews];
}
- (void)layoutSubviews {
    [super layoutSubviews];
//    self.jj_frame = self.frame;
}
- (void)setAnimationOrientation:(JJMaskViewAnimationOrientation)animationOrientation {
    _animationOrientation = animationOrientation;
    switch (animationOrientation) {
        case JJMaskViewAnimationBottom:
        {
            self.siteX = 0.0;
            self.siteY = Scree_Height;
        }
            break;
        case JJMaskViewAnimationTop:
        {
            self.siteX = 0.0;
            self.siteY = 0.0 - Scree_Height;
        }
            break;
        case JJMaskViewAnimationLeft:
        {
            self.siteX = 0.0 - Scree_Width;
            self.siteY = 0.0;
        }
            break;
        case JJMaskViewAnimationRight:
        {
            self.siteX = Scree_Width;
            self.siteY = 0.0;
        }
            break;
        default:
            break;
    }
    self.frame = CGRectMake(self.siteX, self.siteY, Scree_Width, Scree_Height);
}
- (void)makeSubviews
{
//    self.frame = CGRectMake(self.siteX, self.siteY, Scree_Width, Scree_Height);
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
}

- (void)animationStart {
    [UIView animateWithDuration:k_Animate_Duration animations:^{
        self.frame = CGRectMake(0.0, 0.0, Scree_Width, Scree_Height);
//        self.frame = self.jj_frame;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.24 animations:^{
//            self.backgroundColor = [UIColor whiteColor];
            self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:k_JJMaskView_Alpha];
        }];
        
    }];
}

- (void)dismiss
{
    self.backgroundColor = [UIColor clearColor];
    
    !_dismissBlock ? : _dismissBlock();
    
    __weak typeof(JJMaskView) *maskView = self;
    
    [UIView animateWithDuration:k_Animate_Duration animations:^{

        maskView.frame = CGRectMake(self.siteX, self.siteY, Scree_Width, Scree_Height);
        
    } completion:^(BOOL finished) {
        
        if (maskView && [maskView superview]) {
            
            [maskView removeFromSuperview];
//            self = nil;
        }
        
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
//    NSLog(@"[touch.view class] = %@", [touch.view class]);
//    if (![gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
//        return YES;
//    }
//    return NO;
    if ([touch.view isKindOfClass:[JJMaskView class]]) {
        return YES;
    }
    return NO;
    
//    if ([NSStringFromClass([touch.view class]) isEqualToString:@"JJMaskView"]) {
//        return YES;
//    }
//    return NO;
}



@end
