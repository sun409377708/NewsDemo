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

@interface JQHomeController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, strong) NSArray <JQChannel *>*channelList;

@property (nonatomic, weak) JQChannelView *channel;

@property (nonatomic, weak) UIPageViewController *pageVC;

@property (nonatomic, weak) UIScrollView *pageScrollView;

@end

@implementation JQHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _channelList = [JQChannel channelList];
    
    [self setupUI];
}


- (void)setupUI {
    
    JQChannelView *channel = [JQChannelView channelView];
    
    [self.view addSubview:channel];
    
    [channel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
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
    JQNewsListController *listVC = [[JQNewsListController alloc] initWithChannelId:_channelList[1].tid index:1];
    
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
    _pageScrollView = [pageVC.view subviews][0];
}

#pragma mark -
#pragma mark KVO监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
//    NSLog(@"%@ - %@, %@", keyPath, object, change);
    NSLog(@" ===> %@", NSStringFromCGPoint(_pageScrollView.contentOffset));
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
    
//    NSLog(@"要显示的控制器 %@", [pendingViewControllers valueForKey:@"channelIndex"]);
    
   //KVO监听pageController的scrollView中contentOffset变化
    [_pageScrollView addObserver:self forKeyPath:@"contentOffset" options:0 context:NULL];
}

//完成展现控制器
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<JQNewsListController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    NSLog(@"完成是调用 %@", [previousViewControllers valueForKey:@"channelIndex"]);
    
    //完成是取消监听
    [_pageScrollView removeObserver:self forKeyPath:@"contentOffset"];
}

@end
