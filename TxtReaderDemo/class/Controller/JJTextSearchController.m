//
//  JJTextSearchController.m
//  读取txt文件
//
//  Created by liujianjian on 16/6/6.
//  Copyright © 2016年 rdg. All rights reserved.
//

#import "JJTextSearchController.h"
#import "JJConst.h"
#import "MJRefresh.h"

#define kClipTextLength 30

@interface JJTextSearchController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    NSString *_previousKeyword; /**<存储上一次搜索关键字*/
}
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *results;
/**
 *  原始的文档
 */
@property (nonatomic, copy)NSString *content;
/**
 *  搜索结束，未搜索到结果
 */
@property (nonatomic, assign, getter=isEndSearch)BOOL endSearch;


@end

@implementation JJTextSearchController

- (NSMutableArray *)results {
    if (!_results) {
        _results = [NSMutableArray array];
    }
    return _results;
}
//- (void)awakeFromNib {}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"全文搜索";
    
    self.content = [JJTxtReaderManager sharedTxtReaderManager].txt;
    
    [self setupRightBarBtn];
    __weak typeof(self) weakSelf = self;
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        [weakSelf searchWithKeyword:weakSelf.searchBar.text];
    }];
    self.endSearch = YES; // 默认没有搜索
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.searchBar becomeFirstResponder];
}
- (void)setupRightBarBtn {
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    btn.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = btn;
}
- (void)back {
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.tableView.legendFooter.hidden = self.endSearch == YES;
    
    return self.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.textLabel.font = [UIFont systemFontOfSize:16.0];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0];
    }
    JJResultModel *model = self.results[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"位于%.1f%%出",1.0 * model.range.location / self.content.length * 100.0];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:model.clipText];
    [attStr setAttributes:@{NSForegroundColorAttributeName :[UIColor redColor]} range:NSMakeRange(0, model.keyword.length)];
    cell.detailTextLabel.attributedText = attStr;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    JJResultModel *model = self.results[indexPath.row];
    !self.ResultBlock ? : self.ResultBlock(model);
    [self back];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    if (!searchBar.text.length)  return;
    [searchBar resignFirstResponder];
    
    [SVProgressHUD show];
    
    if (![searchBar.text isEqualToString:_previousKeyword]) { // 如果搜索的是新关键字
        self.content = [JJTxtReaderManager sharedTxtReaderManager].txt;
        [self.results removeAllObjects];
        _previousKeyword = searchBar.text;
        self.endSearch = NO;
    }

    [self searchWithKeyword:searchBar.text];
}

- (void)searchWithKeyword:(NSString *)keyword {
    
    self.endSearch = NO; // 开始了搜索
    
    NSMutableString *blankString = [NSMutableString string];
    for (int j = 0; j < keyword.length; j++) { // 搜索到的位置替换成空字符串
        [blankString appendString:@" "];
    }
    
    for (int i = 0; i < 20; i++) {
        NSRange range = [_content rangeOfString:keyword];
        NSLog(@"range = %@", NSStringFromRange(range));
        if (range.location != NSNotFound) {

            NSString *clipText = nil;
            if (range.length < kClipTextLength && range.location + range.length + kClipTextLength <= _content.length) {
                clipText = [_content substringWithRange:NSMakeRange(range.location, kClipTextLength)];
            } else {
                clipText = [_content substringWithRange:range];
            }
            
            JJResultModel *resultModel = [[JJResultModel alloc] init];
            resultModel.range = range;
            resultModel.keyword = keyword;
            clipText = [clipText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            clipText = [clipText stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            clipText = [clipText stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            resultModel.clipText = clipText;
            
            [self.results addObject:resultModel];
            
            _content = [_content stringByReplacingOccurrencesOfString:keyword withString:blankString options:NSAnchoredSearch range:range];
        } else {
            self.endSearch = YES; // 没有数据就结束搜索
            break;
        }
    }
    [SVProgressHUD dismiss];
    
    if (!self.results.count) {
        [SVProgressHUD showErrorWithStatus:@"未搜索到结果"];
    }
    /*
     noticeNoMoreData   // 已加载全部数据
     endRefreshing      // 上拉继续刷新
     */
//    [self.tableView.legendFooter setHidden:YES]; // 隐藏footer
    
    [self.tableView.legendFooter endRefreshing];
    [self.tableView reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}







@end




@implementation JJResultModel


@end



