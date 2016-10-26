//
//  JQNewsCell.h
//  NewsDemo
//
//  Created by maoge on 16/10/26.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JQNewsList;

@interface JQNewsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyLabel;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *extraIcon;

@property (nonatomic, strong) JQNewsList *newsItem;


@end
