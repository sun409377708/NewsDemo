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

@interface JQHomeController ()

@end

@implementation JQHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadData];
    
    [self setupUI];
}

- (void)loadData {
    
    NSArray *array = [JQChannel channelList];
    
    NSLog(@"%@", array);
}

- (void)setupUI {
    
    JQChannelView *channel = [JQChannelView channelView];
    
    [self.view addSubview:channel];
    
    [channel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.leading.trailing.equalTo(self.view);
        make.height.mas_equalTo(38);
    }];
}


@end
