//
//  ViewController.m
//  读取txt文件
//
//  Created by liujianjian on 16/5/20.
//  Copyright © 2016年 rdg. All rights reserved.
//

#import "ViewController.h"
#import "JJTxtReaderController.h"
#import "JJTxtParse.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)reader:(id)sender {
    
    JJTxtReaderController *txtReader = [[JJTxtReaderController alloc] init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"五界至尊" ofType:@"txt"];
    txtReader.txtPath = path;
    //    [self.navigationController pushViewController:txtReader animated:YES];
    [self presentViewController:txtReader animated:YES completion:NULL];
    
}

@end
