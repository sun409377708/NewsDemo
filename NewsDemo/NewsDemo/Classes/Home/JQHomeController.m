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

@interface JQHomeController ()

@property (nonatomic, strong) NSArray *channelList;

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
    
    // 2. 设置内容子控制器
    JQNewsListController *listVC = [[JQNewsListController alloc] init];
    
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


@end
