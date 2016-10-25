//
//  JQMainTabController.m
//  NewsDemo
//
//  Created by maoge on 16/10/25.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import "JQMainTabController.h"

@interface JQMainTabController ()

@end

@implementation JQMainTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = @[ @{@"className" : @"JQHomeController", @"title" : @"首页", @"image" : @"tabbar_icon_news_normal"}];
    
    NSMutableArray *arrM = [NSMutableArray array];
    
    //遍历数组
    for (NSDictionary *dict in array) {
        
        [arrM addObject: [self childControllerWithDict:dict]];
    }
    
    self.viewControllers = arrM.copy;
    
}

- (void)addChildViewControllers {
    
}

- (UIViewController *)childControllerWithDict:(NSDictionary *)dict {
    
    // 1. 创建控制器
    NSString *className = dict[@"className"];
    
    Class cls = NSClassFromString(className);
    
    NSAssert(cls != nil, @"必须传入控制器");
    
    UIViewController *vc = [[cls alloc] init];
    
    // 2. 设置title
    NSString *title = dict[@"title"];
    
    vc.title = title;
    
    // 3. 设置图片
    NSString *imageName = dict[@"image"];
    
    [vc.tabBarItem setImage:[UIImage imageNamed:imageName]];
    
    // 4. 设置导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    return nav;
}

@end
