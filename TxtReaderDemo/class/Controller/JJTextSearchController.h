//
//  JJTextSearchController.h
//  读取txt文件
//
//  Created by liujianjian on 16/6/6.
//  Copyright © 2016年 rdg. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void(^ClickResultBlock)(NSIndexPath *);
@class JJResultModel;

@interface JJTextSearchController : UIViewController

@property (nonatomic, copy)void(^ResultBlock)(JJResultModel *);


@end

@interface JJResultModel : NSObject

@property (nonatomic, assign)NSRange range;
@property (nonatomic, copy)NSString *keyword;
@property (nonatomic, copy)NSString *clipText;




@end
