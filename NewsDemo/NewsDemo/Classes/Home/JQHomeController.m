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

@interface JQHomeController ()<UIPageViewControllerDataSource>

@property (nonatomic, strong) NSArray <JQChannel *>*channelList;

@property (nonatomic, weak) JQChannelView *channel;

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
    
}


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

@end
