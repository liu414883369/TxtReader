//
//  JJTxtReader.m
//  读取txt文件
//
//  Created by ; on 16/5/22.
//  Copyright © 2016年 rdg. All rights reserved.
//

#import "JJTxtReaderController.h"
#import "JJConst.h"
#import "JJBottomBar.h"
#import "JJTopBar.h"
#import "JJCenterBtn.h"
#import "JJChapterView.h"
#import "SVProgressHUD.h"
#import "JJShowTxtController.h"
#import "JJChapterModel.h"
#import "JJBookmarkModel.h"
#import "JJMoreActionView.h"
#import "JJTextSearchController.h"
//#import "JJSelectColorView.h"

@interface JJTxtReaderController ()<JJTopBarDelegate, JJChapterViewDelegate, UIPageViewControllerDelegate, UIPageViewControllerDataSource, JJMoreActionViewDelegate>
{
    UIPageViewController *_pageViewController;
//    UIActivityIndicatorView *_activityIndicatorView;
    JJMoreActionView *_moreActionView; /**<字体调节view */
}
@property (nonatomic, strong) JJBottomBar           *bottomBar;
@property (nonatomic, strong) JJTopBar              *topBar;
@property (nonatomic, strong) JJCenterBtn           *centerBtn;
/**
 *  右下角进度显示
 */
@property (nonatomic, strong) UILabel               *proLabel;
/**
 *  状态栏样式
 */
@property (nonatomic, assign) UIStatusBarStyle      statusBarStyle;

@end

@implementation JJTxtReaderController

#pragma mark - view life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [JJTxtReaderManager sharedTxtReaderManager].txtAttribute.textBackgroundColor;
    
    self.statusBarStyle = UIStatusBarStyleLightContent;
    [self setNeedsStatusBarAppearanceUpdate];
    
    // 显示隐藏bar手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stateControl)];
    [self.view addGestureRecognizer:tap];
    
    [self setupPageViewController];
    
    // 右下角进度显示框
    UILabel *proLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, screenHeight() - kProgressLabelH, screenWidth()-10.0, kProgressLabelH)];
    proLabel.backgroundColor = [UIColor clearColor];
    //    proLabel.text = @"0%";
    proLabel.textAlignment = NSTextAlignmentRight;
    proLabel.font = [UIFont systemFontOfSize:12.0];
    [self.view addSubview:proLabel];
    self.proLabel = proLabel;

    [self makeTopBar];
    
    [self makeCenterBtn];
    
    [self makeBottomBar];
    
    [self parseTxt]; // 解析
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
/**
 *  解析文档
 */
- (void)parseTxt {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showWithStatus:kTxtParseHint];
    JJTxtReaderManager *manager = [JJTxtReaderManager sharedTxtReaderManager];
    [manager parseWithPath:self.txtPath completion:^(BOOL isCompletion) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            
            self.bottomBar.minimumValue = 0;
            self.bottomBar.maximumValue = manager.totalPage - 1; // 总页数是从0开始，不是从1开始的；totalPage是数组的总长度，应该-1
            [self showPage:manager.currentPage];
        });
        
    } onQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];

}

#pragma mark - subviews init
- (void)setupPageViewController {
    if (_pageViewController) {
        _pageViewController.delegate = nil;
        _pageViewController.dataSource = nil;
        [_pageViewController removeFromParentViewController];
        _pageViewController = nil;
    }
    // 设置UIPageViewController的配置项(可以设置书脊)
    NSDictionary *options =[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin]
                                                       forKey: UIPageViewControllerOptionSpineLocationKey];
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                                                          navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                        options:options];
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    _pageViewController.view.frame = self.view.bounds;
    [self.view addSubview:_pageViewController.view];
    [self addChildViewController:_pageViewController];
}
- (void)showPage:(NSUInteger)page {
    
    

    
    JJShowTxtController *showTxtVC = [self showTxtControllerWithPage:page];
    [_pageViewController setViewControllers:@[showTxtVC]
                                  direction:UIPageViewControllerNavigationDirectionForward
                                   animated:NO
                                 completion:NULL];
}
- (JJShowTxtController *)showTxtControllerWithPage:(NSUInteger)page {
    [JJTxtReaderManager sharedTxtReaderManager].txtAttribute.currentPage = page;
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [JJStoreTool storeTxtAttribute:[JJTxtReaderManager sharedTxtReaderManager].txtAttribute];
//    });
    [self hideBar];
    self.bottomBar.currentPage = page;
    self.proLabel.text = [NSString stringWithFormat:@"%.1f%%", 1.0 * page / ([JJTxtReaderManager sharedTxtReaderManager].totalPage - 1) * 100.0];
    
    JJShowTxtController *showTxtController = [[JJShowTxtController alloc] init];
    showTxtController.page = page;
    showTxtController.view.backgroundColor = [JJTxtReaderManager sharedTxtReaderManager].txtAttribute.textBackgroundColor;
    return showTxtController;
    
}
#pragma mark- UIPageViewControllerDataSource

// 返回上一个ViewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    JJShowTxtController *showTxtVC = (JJShowTxtController *)viewController;
    if (showTxtVC.page == 0) {
        [SVProgressHUD showInfoWithStatus:kFirstPageHint];
        [self hiddenHUD];
        return nil;
    }
    return [self showTxtControllerWithPage:showTxtVC.page - 1];
}
// 返回下一个ViewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    JJShowTxtController *showTxtVC = (JJShowTxtController *)viewController;
    if (showTxtVC.page == [JJTxtReaderManager sharedTxtReaderManager].totalPage - 1) { // 页数从0开始的
        [SVProgressHUD showInfoWithStatus:kLastPageHint];
        [self hiddenHUD];
        return nil;
    }
    return [self showTxtControllerWithPage:showTxtVC.page + 1];
    
}
/**
 *  底部进度条
 */
- (void)makeBottomBar {

    JJBottomBar *bottomBar = [JJBottomBar viewFromXib];
    bottomBar.frame = CGRectMake(0, screenHeight()-JJBottomBarH, screenWidth(), JJBottomBarH);
    
    [self.view addSubview:bottomBar];
    self.bottomBar = bottomBar;
    
    __weak typeof(self) weakSelf = self;
    
    bottomBar.valueEndChanged = ^(CGFloat pro){
        NSLog(@"%f",pro);
        [weakSelf showPage:(NSUInteger)pro];
    };
}

/**
 *  顶部控件
 */
- (void)makeTopBar {
    JJTopBar *topBar = [JJTopBar viewFromXib];
    topBar.frame = CGRectMake(0, 0, screenWidth(), JJTopBarH);
    topBar.delegate = self;
    topBar.titleLabel.text = [self titleWithPath:self.txtPath];
    [self.view addSubview:topBar];
    self.topBar = topBar;
}
/**
 *  中间按钮
 */
- (void)makeCenterBtn {
    JJCenterBtn *centerBtn = [JJCenterBtn buttonWithType:UIButtonTypeCustom];
    centerBtn.frame = CGRectMake(0, (screenHeight() - JJCenterBtnH) / 2.0, JJCenterBtnW, JJCenterBtnH);
    [centerBtn setImage:[UIImage imageNamed:@"app_tr_toolbar_l_btn_icon"] forState:UIControlStateNormal];
    [centerBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [self.view addSubview:centerBtn];
    self.centerBtn = centerBtn;
    [self.centerBtn addTarget:self action:@selector(chapters) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 事件

/**
 *  章节界面初始化及动画
 */
- (void)hiddenHUD {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}
// 点击中间按钮事件
- (void)chapters {

    [self hideBar];
    JJChapterView *chapterView = [[JJChapterView alloc] initWithFrame:CGRectMake(0, 0, screenWidth(), screenHeight())];
    chapterView.animationOrientation = JJMaskViewAnimationLeft;
    chapterView.delegate = self;
//    [self.view addSubview:chapterView];
    [self.view.window addSubview:chapterView];
    [chapterView animationStart];
    chapterView.currentPage = self.currentPage;
    chapterView.dataSource = [JJTxtReaderManager sharedTxtReaderManager].chapters;
    
}
#pragma mark - JJChapterViewDelegate

- (void)chapterView:(JJChapterView *)view type:(TableViewShowType)type indexPath:(NSIndexPath *)indexPath {
    
    JJTxtReaderManager *manager = [JJTxtReaderManager sharedTxtReaderManager];
    if (type == TableViewShowChapters) {
        JJChapterModel *chapterModel = manager.chapters[indexPath.row];
        NSUInteger page = [manager pageOfRange:chapterModel.range];
        [self showPage:page];
    } else {
        
    }
}
/**
 *  显示隐藏
 */
- (void)stateControl {

    if (self.bottomBar.hidden) {
        [self.bottomBar moveShow];
        [self.topBar moveShow];
        [self.centerBtn moveShow];
        self.statusBarStyle = UIStatusBarStyleLightContent;

    } else {
        [self.bottomBar moveHidden];
        [self.topBar moveHidden];
        [self.centerBtn moveHidden];
        self.statusBarStyle = UIStatusBarStyleDefault;
    }
    [self setNeedsStatusBarAppearanceUpdate];
}
/**
 *  隐藏bar
 */
- (void)hideBar {
    if (self.bottomBar.hidden) return;
    
    [self.bottomBar moveHidden];
    [self.topBar moveHidden];
    [self.centerBtn moveHidden];
    self.statusBarStyle = UIStatusBarStyleDefault;
    [self setNeedsStatusBarAppearanceUpdate];
}
#pragma mark - statusBar

//- (BOOL)prefersStatusBarHidden {}
/**
 View controller-based status bar appearance YES
 setNeedStatusBarAppearanceUpdate
 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.statusBarStyle;
}

#pragma mark - JJTopBarDelegate

/**
 *  返回
 */
- (void)back {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}
/**
 *  添加书签
 */
- (void)bookmark {
    [SVProgressHUD showInfoWithStatus:@"添加书签成功!"];
    [self hiddenHUD];
}
/**
 *  更多
 */
- (void)more {
    JJMoreActionView *moreActionView = [JJMoreActionView viewFromXib];
    moreActionView.frame = CGRectMake(0.0, 0.0, screenWidth(), screenHeight());
    moreActionView.delegate = self;
    moreActionView.animationOrientation = JJMaskViewAnimationRight;
    [self.view.window addSubview:moreActionView];
    [moreActionView animationStart];
    _moreActionView = moreActionView;
}
#pragma mark - JJMoreActionViewDelegate
/**
 *  夜间模式
 */
- (void)moreActionView:(JJMoreActionView *)view switch:(UIButton *)btn {
    NSLog(@"swotch");
    JJTxtReaderManager *manager = [JJTxtReaderManager sharedTxtReaderManager];
    if (btn.selected) {
        manager.txtAttribute.textColor = [UIColor lightGrayColor];
        manager.txtAttribute.textBackgroundColor = [UIColor colorWithWhite:0.074 alpha:1.000];
    } else {
        manager.txtAttribute.textColor = [UIColor blackColor];
        manager.txtAttribute.textBackgroundColor = [UIColor whiteColor];
    }
    [self showPage:manager.currentPage];
}
/**
 *  字体调节
 */
- (void)moreActionView:(JJMoreActionView *)view fontSlider:(JJSlider *)slider{
    
    JJTxtReaderManager *manager = [JJTxtReaderManager sharedTxtReaderManager];
    manager.txtAttribute.fontSize = slider.value;

    [self parseTxt]; // 解析

}

/**
 *  搜索关键字
 */
- (void)moreActionView:(JJMoreActionView *)view search:(UIButton *)btn {
    [_moreActionView dismiss];
    JJTextSearchController *txtSearchController = [[JJTextSearchController alloc] initWithNibName:@"JJTextSearchController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:txtSearchController];
    [self presentViewController:nav animated:YES completion:NULL];
    __weak typeof(self) weakSelf = self;
    txtSearchController.ResultBlock = ^(JJResultModel *model){
        NSUInteger page = [[JJTxtReaderManager sharedTxtReaderManager] pageOfRange:model.range];
        [weakSelf showPage:page];
    };
}
/**
 *  字体颜色
 */
- (void)moreActionView:(JJMoreActionView *)view textColor:(UIColor *)textColor {
    JJTxtReaderManager *manager = [JJTxtReaderManager sharedTxtReaderManager];
    
    manager.txtAttribute.textColor = textColor;
    
    [self showPage:manager.currentPage];
}
/**
 *  背景色
 */
- (void)moreActionView:(JJMoreActionView *)view backgroundColor:(UIColor *)backgroundColor {
    JJTxtReaderManager *manager = [JJTxtReaderManager sharedTxtReaderManager];
    
    manager.txtAttribute.textBackgroundColor = backgroundColor;
    
    [self showPage:manager.currentPage];
}

// 根据路径返回书名
- (NSString *)titleWithPath:(NSString *)path {
    if (!path.length) return @"";
    
    NSString *name = [[path stringByDeletingPathExtension] lastPathComponent];
    return name;
}

- (NSUInteger)currentPage {
    JJShowTxtController *showVC = [_pageViewController.childViewControllers lastObject];
    NSUInteger page = showVC.page;
    return page;
}









@end
