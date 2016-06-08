//
//  JJShowTxtController.m
//  读取txt文件
//
//  Created by liujianjian on 16/5/30.
//  Copyright © 2016年 rdg. All rights reserved.
//

#import "JJShowTxtController.h"
#import "JJShowTxtView.h"
#import "JJConst.h"

@interface JJShowTxtController ()
@property (nonatomic, copy)NSString *text;

@end

@implementation JJShowTxtController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JJTxtReaderManager *manager = [JJTxtReaderManager sharedTxtReaderManager];
    
    JJShowTxtView *view = [[JJShowTxtView alloc] init];
    view.backgroundColor = manager.txtAttribute.textBackgroundColor;
    view.text = [manager stringOfPage:self.page];
    // 设置frame会调用drawrect
    view.frame = CGRectMake(kShowTxtViewLeftGap,
                            kShowTxtViewTopGap,
                            manager.eachPageSize.width,
                            manager.eachPageSize.height);
    [self.view addSubview:view];
}









@end
