//
//  JQNewsDetailController.m
//  NewsDemo
//
//  Created by maoge on 16/10/27.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import "JQNewsDetailController.h"
#import "JQNewsList.h"

@interface JQNewsDetailController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation JQNewsDetailController

- (void)loadView {
    _webView = [[UIWebView alloc] init];
    
    self.view = _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}

- (void)loadData {
    
    [[JQNetworkManager sharedManager] newsDetailWithDocId:_item.docid completion:^(NSDictionary *dict, NSError *error) {
        
        NSLog(@"%@", dict);
        // 取出body 图片 video
        NSString *body = dict[@"body"];
        NSArray *img = dict[@"img"];
        NSArray *video = dict[@"video"];
        
        //显示界面
        [self.webView loadHTMLString:body baseURL:nil];
    }];
}

@end
