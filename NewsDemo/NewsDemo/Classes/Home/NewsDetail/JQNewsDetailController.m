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
        
        //插入图片
        //	src = http://cms-bucket.nosdn.127.net/bacf0bf7f99545c7b9ebf9c2fd362b9720161027192112.jpeg;
        //  ref = <!--IMG#0-->;
        
        //查找body中ref对于的位置进行替换
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
        
        //显示界面
        [self.webView loadHTMLString:body baseURL:nil];
    }];
}

@end
