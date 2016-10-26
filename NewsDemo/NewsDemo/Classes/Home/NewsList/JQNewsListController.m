//
//  JQNewsListController.m
//  NewsDemo
//
//  Created by maoge on 16/10/25.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import "JQNewsListController.h"

static NSString *cellId = @"cellId";

@interface JQNewsListController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation JQNewsListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self loadData];
}

- (void)loadData {
    
    [[JQNetworkManager sharedManager] newsListWithChannel:@"T1348649079062" start:0 completion:^(NSArray *array, NSError *error) {
        
        NSLog(@"%@", array);
    }];
}

- (void)setupUI {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark -
#pragma mark dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    return cell;
}


@end
