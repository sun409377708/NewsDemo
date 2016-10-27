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
