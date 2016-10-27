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
    
}


@end
