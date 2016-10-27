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
    
    [self setNavView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}

- (void)setNavView {
    // 1. 创建导航条
    UINavigationBar *navBar = [[UINavigationBar alloc] init];
    
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"新闻内容"];
    
    item.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    navBar.items = @[item];
    
    [self.view addSubview:navBar];
    
    [navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(64);
    }];
    
    _webView.scrollView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
}

- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadData {
    
    [[JQNetworkManager sharedManager] newsDetailWithDocId:_item.docid completion:^(NSDictionary *dict, NSError *error) {
        
        NSLog(@"%@", dict);
        // 取出body 图片 video
        NSString *body = dict[@"body"];
        NSArray *img = dict[@"img"];
        NSArray *video = dict[@"video"];
        
        
        //查找body中的图片 ref对于的位置进行替换
        for (NSDictionary *dict in img) {
            
            // 1> 获取ref内容
            NSString *ref = dict[@"ref"];
            
            // 2> 找出其位置
            NSRange range = [body rangeOfString:ref];
            
            // 3> 判断是否找到
            if (range.location == NSNotFound) {
                continue;
            }
            
            // 4> 替换 range的内容
            NSString *imgStr = [NSString stringWithFormat:@"<img src=\"%@\" />", dict[@"src"]];
            body = [body stringByReplacingCharactersInRange:range withString:imgStr];
        }
        
        //查找body中的video ref对于的位置进行替换
        
        for (NSDictionary *dict in video) {
            // 1> 获取ref内容
            NSString *ref = dict[@"ref"];
            
            // 2> 找出其位置
            NSRange range = [body rangeOfString:ref];
            
            // 3> 判断是否找到
            if (range.location == NSNotFound) {
                continue;
            }
            
            // 4> 替换 range的内容
            NSString *videoStr = [NSString stringWithFormat:@"<video src=\"%@\"></video>", dict[@"m3u8_url"]];
            body = [body stringByReplacingCharactersInRange:range withString:videoStr];
        }
        
        //将css描述添加在body前面
        body = [[self cssString] stringByAppendingString:body];
        
        //显示界面
        [self.webView loadHTMLString:body baseURL:nil];
    }];
}

//加载css
- (NSString *)cssString {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"news.css" ofType:nil];
    
    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
}

@end
