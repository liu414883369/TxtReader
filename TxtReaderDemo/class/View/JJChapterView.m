//
//  JJChaptersView.m
//  读取txt文件
//
//  Created by liujianjian on 16/5/25.
//  Copyright © 2016年 rdg. All rights reserved.
//

#import "JJChapterView.h"
#import "JJConst.h"
#import "JJChapterModel.h"
#import "JJChapterCell.h"

#define kSegCtlGap 20.0

@interface JJChapterView()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIView             *backView;
@property (strong, nonatomic) UISegmentedControl *segCtl;
@property (strong, nonatomic) UITableView        *tableView;
@property (nonatomic, assign) TableViewShowType  showType;
/**
 *  当前看到的章节索引
 */
@property (nonatomic, strong)NSIndexPath *currentIndexPath;
@end

@implementation JJChapterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeSubViews];
    }
    return self;
}

- (void)makeSubViews {
    // 背景
    UIView *backView = [[UIView alloc] init];
    backView.frame = CGRectMake(0, 0, self.width * 0.7, self.height);
    backView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"app_tr_list_bg"]];
    [self addSubview:backView];
    self.backView = backView;
    
    // segCtl
    UISegmentedControl *segCtl = [[UISegmentedControl alloc] initWithItems:@[@"目录", @"书签"]];
    segCtl.frame = CGRectMake(kSegCtlGap,
                              kStatusBarH + 5.0,
                              self.backView.width - kSegCtlGap * 2,
                              30.0);
    segCtl.tintColor = [UIColor darkTextColor];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:14.0];
    [segCtl setTitleTextAttributes:dict forState:UIControlStateNormal];
    [segCtl setTitleTextAttributes:dict forState:UIControlStateSelected];
    segCtl.selectedSegmentIndex = 0;
    [self.backView addSubview:segCtl];
    [segCtl addTarget:self action:@selector(segCtlValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    // tableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0,
                                                                           segCtl.bottom,
                                                                           self.backView.width,
                                                                           self.backView.height - segCtl.bottom)
                                                          style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.backView addSubview:tableView];
    self.tableView = tableView;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:@"JJChapterCell" bundle:nil] forCellReuseIdentifier:@"JJChapterCell"];
}
- (void)layoutSubviews {
    [super layoutSubviews];
}
- (void)segCtlValueChanged:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
        case 0:
        {
            self.showType = TableViewShowChapters;
        }
            break;
        case 1:
        {
            self.showType = TableViewShowBookmark;
        }
            break;
        default:
            break;
    }
    
}
- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    [self.tableView reloadData];
    // reloadData结束才会执行主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        JJChapterModel *model = [[JJTxtReaderManager sharedTxtReaderManager] chapterOfPage:self.currentPage];
        NSUInteger index = [self.dataSource indexOfObject:model];
        self.currentIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
        [self.tableView scrollToRowAtIndexPath:self.currentIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        JJChapterCell *cell = [self.tableView cellForRowAtIndexPath:self.currentIndexPath];
        cell.readView.hidden = NO;
    });
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JJChapterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JJChapterCell"];
    cell.backgroundColor = [UIColor clearColor];

    JJChapterModel *model = self.dataSource[indexPath.row];
    [cell loadWithData:model];
    
    if (indexPath == self.currentIndexPath) {
        cell.readView.hidden = NO;
    } else {
        cell.readView.hidden = YES;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"%s", __func__);

    if ([self.delegate respondsToSelector:@selector(chapterView:type:indexPath:)]) {
        
        [self.delegate chapterView:self type:self.showType indexPath:indexPath];
        
    }
    [self dismiss];
}








@end
