//
//  JQNewsListController.m
//  NewsDemo
//
//  Created by maoge on 16/10/25.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import "JQNewsListController.h"
#import "JQNewsList.h"
#import "JQNewsNormalCell.h"

static NSString *cellId = @"cellId";

@interface JQNewsListController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *newsList;

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation JQNewsListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _newsList = [NSMutableArray array];
    
    [self setupUI];
    
    [self loadData];
}

- (void)loadData {
    
    [[JQNetworkManager sharedManager] newsListWithChannel:@"T1348649079062" start:0 completion:^(NSArray *array, NSError *error) {
        
        NSArray *list = [NSArray yy_modelArrayWithClass:[JQNewsList class] json:array];
        
        _newsList = [NSMutableArray arrayWithArray:list];
        
        //刷新数据
        [self.tableView reloadData];
        
    }];
}

- (void)setupUI {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 100;
    
//    [tableView registerClass:[JQNewsNormalCell class] forCellReuseIdentifier:cellId];
    [tableView registerNib:[UINib nibWithNibName:@"JQNewsNormalCell" bundle:nil] forCellReuseIdentifier:cellId];
    
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    _tableView = tableView;
}

#pragma mark -
#pragma mark dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _newsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JQNewsNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    JQNewsList *list = _newsList[indexPath.row];
    
    [cell.iconView sd_setImageWithURL:[NSURL URLWithString:list.imgsrc]];
    cell.titleLabel.text = list.title;
    cell.sourceLabel.text = list.source;
    cell.replyLabel.text = [NSString stringWithFormat:@"%zd", list.replyCount];
    
    return cell;
}


@end
