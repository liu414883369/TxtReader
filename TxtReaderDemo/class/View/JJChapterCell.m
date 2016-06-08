//
//  JJChapterCell.m
//  读取txt文件
//
//  Created by liujianjian on 16/6/2.
//  Copyright © 2016年 rdg. All rights reserved.
//

#import "JJChapterCell.h"
#import "JJChapterModel.h"
#import "JJTxtReaderManager.h"

@interface JJChapterCell ()
@property (strong, nonatomic) IBOutlet UILabel *progressLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation JJChapterCell

- (void)loadWithData:(id)data {
    JJChapterModel *model = data;
    self.titleLabel.text = model.title;
    NSUInteger length = [JJTxtReaderManager sharedTxtReaderManager].txt.length;
    self.progressLabel.text = [NSString stringWithFormat:@"%.1f%%", 1.0 * model.range.location / length * 100.0];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
