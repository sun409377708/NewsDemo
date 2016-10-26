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
    
    self.tabBar.tintColor = [UIColor cz_colorWithHex:0xDF0000];
    
    NSArray *array = @[ @{@"className" : @"JQHomeController", @"title" : @"新闻", @"image"
                          : @"news"},
                        @{@"className" : @"UIViewController", @"title" : @"阅读", @"image" : @"reader"},
                        @{@"className" : @"UIViewController", @"title" : @"视频", @"image" : @"media"},
                        @{@"className" : @"UIViewController", @"title" : @"话题", @"image" : @"bar"},
                        @{@"className" : @"UIViewController", @"title" : @"我", @"image" : @"me"}
                        ];
    
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
    NSString *imageName = [NSString stringWithFormat:@"tabbar_icon_%@_normal", dict[@"image"]];
    
    [vc.tabBarItem setImage:[UIImage imageNamed:imageName]];
    
     NSString *imageNameHL = [NSString stringWithFormat:@"tabbar_icon_%@_highlight", dict[@"image"]];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:imageNameHL] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 4. 设置导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    return nav;
}

@end
