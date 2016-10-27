//
//  JQNewsDetailController.m
//  NewsDemo
//
//  Created by maoge on 16/10/27.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import "JQNewsDetailController.h"

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
    
}

@end
