//
//  JQHomeController.m
//  NewsDemo
//
//  Created by maoge on 16/10/25.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import "JQHomeController.h"
#import "JQChannelView.h"
#import "JQChannel.h"
#import "JQNewsListController.h"
#import "JQNewsDetailController.h"

extern NSString *const JQNewsListDidSelectedDocNotification;

@interface JQHomeController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate, JQChannelViewDelegate>

@property (nonatomic, strong) NSArray <JQChannel *>*channelList;

@property (nonatomic, weak) JQChannelView *channel;

@property (nonatomic, weak) UIPageViewController *pageVC;

@property (nonatomic, weak) UIScrollView *pageScrollView;

//当前控制器
@property (nonatomic, weak) JQNewsListController *currentListVC;
//下一个控制器
@property (nonatomic, weak) JQNewsListController *nextListVC;
@end

@implementation JQHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _channelList = [JQChannel channelList];
    
    [self setupUI];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:JQNewsListDidSelectedDocNotification object:nil];
}

- (void)dealloc {
    //销毁通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark 实现通知方法
- (void)notification:(NSNotification *)noty {
    
    // 1. 创建详情控制器
    JQNewsDetailController *detailVC = [[JQNewsDetailController alloc] init];
    
    detailVC.item = noty.object;
    
    detailVC.hidesBottomBarWhenPushed = YES;
    
    // 2. push 详情控制器
    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma mark -
#pragma mark delegate method
- (void)channelView:(JQChannelView *)channelView didSelectedIndex:(NSInteger)index {
    // 获取当前控制器
    JQNewsListController *vc = _pageVC.viewControllers[0];

    // 0. 如果选的是当前控制器, 直接retrun
    if (index == vc.channelIndex) {
        return;
    }
    
    // 1. 设置选中标签放大, 之前的缩小
    [channelView changeLabelWithIndex:index scale:1.0];
    [channelView changeLabelWithIndex:vc.channelIndex scale:0];
    
    //重置标签
    [_channel resetLabel];
    
    // 移动列表页面 更新控制器
    JQNewsListController *nextVC = [[JQNewsListController alloc] initWithChannelId:_channelList[index].tid index:index];
    
    
    UIPageViewControllerNavigationDirection dir = UIPageViewControllerNavigationDirectionForward;
    
    if (index < vc.channelIndex) {
        dir = UIPageViewControllerNavigationDirectionReverse;
    }
    
    [_pageVC setViewControllers:@[nextVC] direction:dir animated:YES completion:nil];
    
}


#pragma mark -
#pragma mark KVO监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
//    NSLog(@" ===> %@", NSStringFromCGPoint(_pageScrollView.contentOffset));
    
    //计算偏移值
    CGFloat width = _pageScrollView.bounds.size.width;
    CGFloat offset = ABS(_pageScrollView.contentOffset.x - width);
    
    CGFloat scale = offset / width;
    [_channel changeLabelWithIndex:_currentListVC.channelIndex scale: (1 - scale)];
    [_channel changeLabelWithIndex:_nextListVC.channelIndex scale:scale];
}


#pragma mark -
#pragma mark pageController 的数据源方法

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(JQNewsListController *)viewController {
    
    // 1.取出当前控制器
    NSInteger index = viewController.channelIndex;
    index--;
    
    // 2.进行判断
    if (index < 0) {
        NSLog(@"前面没有了");
        return nil;
    }
    
    JQNewsListController *vc = [[JQNewsListController alloc] initWithChannelId:_channelList[index].tid index:index];
    return vc;
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(JQNewsListController *)viewController{
    
    // 1.取出当前控制器
    NSInteger index = viewController.channelIndex;
    
    index++;
    // 2.进行判断
    if (index > _channelList.count) {
        NSLog(@"后面没有了");
        return nil;
    }
    JQNewsListController *vc = [[JQNewsListController alloc] initWithChannelId:_channelList[index].tid index:index];
    return vc;
}

#pragma mark -
#pragma mark pageController Delegate方法

//将要展示下一个控制器
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<JQNewsListController *> *)pendingViewControllers {
    
//    NSLog(@"当前控制器%@", [pageViewController.viewControllers valueForKey:@"channelIndex"]);
    //当前控制器
    _currentListVC = pageViewController.viewControllers[0];
    
//    NSLog(@"要显示的控制器 %@", [pendingViewControllers valueForKey:@"channelIndex"]);
    //要显示的控制器
    _nextListVC = pendingViewControllers[0];
    
   //KVO监听pageController的scrollView中contentOffset变化
    [_pageScrollView addObserver:self forKeyPath:@"contentOffset" options:0 context:NULL];
}

//完成展现控制器
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<JQNewsListController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
//    NSLog(@"完成是调用 %@", [previousViewControllers valueForKey:@"channelIndex"]);
    
    //完成是取消监听
    [_pageScrollView removeObserver:self forKeyPath:@"contentOffset"];
    
    [_channel resetLabel];
}


- (void)setupUI {
    
    //隐藏并创建导航条
    self.navigationController.navigationBar.hidden = YES;
    
    // 1. 创建导航条
    UINavigationBar *navBar = [[UINavigationBar alloc] init];
    
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"网易新闻"];
    
    item.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"left" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    navBar.items = @[item];
    
    [self.view addSubview:navBar];
    
    [navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(64);
    }];
    
    JQChannelView *channel = [JQChannelView channelView];
    
    channel.delegate = self;
    [self.view addSubview:channel];
    
    [channel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navBar.mas_bottom);
        make.leading.trailing.equalTo(self.view);
        make.height.mas_equalTo(38);
    }];
    
    channel.channelList = _channelList;
    
    _channel = channel;
    
    //设置分页控制器
    [self setPageController];
}

- (void)setPageController {
    
    // 1. 实例化page控制器
    UIPageViewController *pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    pageVC.dataSource = self;
    pageVC.delegate = self;
    // 2. 设置内容子控制器
    JQNewsListController *listVC = [[JQNewsListController alloc] initWithChannelId:_channelList[0].tid index:0];
    
    // 2.1 绑定当前控制器的值
    _currentListVC = listVC;
    
    // 3. 添加至page控制器中
    [pageVC setViewControllers:@[listVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    // 4. 添加视图, 完成自动布局
    [self addChildViewController:pageVC];
    [self.view addSubview:pageVC.view];
    
    [pageVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_channel.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [pageVC didMoveToParentViewController:self];
    
    //关联属性
    _pageVC = pageVC;
    
    if ([pageVC.view.subviews[0] isKindOfClass:[UIScrollView class]]) {
        _pageScrollView = [pageVC.view subviews][0];
    }
}

@end
