//
//  JQNewsListController.m
//  NewsDemo
//
//  Created by maoge on 16/10/25.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import "JQNewsListController.h"
#import "JQNewsList.h"
#import "JQNewsCell.h"

static NSString *normalId = @"normalId";
static NSString *extraId = @"extraId";

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
    
    [tableView registerNib:[UINib nibWithNibName:@"JQNewsNormalCell" bundle:nil] forCellReuseIdentifier:normalId];

    [tableView registerNib:[UINib nibWithNibName:@"JQExtraImageCell" bundle:nil] forCellReuseIdentifier:extraId];

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

    JQNewsList *list = _newsList[indexPath.row];
    
    //判断cellID
    NSString *cellId;
    if (list.imgextra.count > 0) {
        cellId = extraId;
    }else {
        cellId = normalId;
    }
    
    JQNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    [cell.iconView sd_setImageWithURL:[NSURL URLWithString:list.imgsrc]];
    cell.titleLabel.text = list.title;
    cell.sourceLabel.text = list.source;
    cell.replyLabel.text = [NSString stringWithFormat:@"%zd", list.replyCount];
    
    NSInteger index = 0;
    for (NSDictionary *dict in list.imgextra) {
        
        NSURL *url = [NSURL URLWithString:dict[@"imgsrc"]];
        
        UIImageView *iv = cell.extraIcon[index++];
        
        [iv sd_setImageWithURL:url];
    }
    
    return cell;
}


@end
