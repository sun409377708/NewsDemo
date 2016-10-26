//
//  JQNewsCell.m
//  NewsDemo
//
//  Created by maoge on 16/10/26.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import "JQNewsCell.h"
#import "JQNewsList.h"

@interface JQNewsCell()

@end

@implementation JQNewsCell

- (void)setNewsItem:(JQNewsList *)newsItem {
    _newsItem = newsItem;
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:newsItem.imgsrc]];
    _titleLabel.text = newsItem.title;
    _sourceLabel.text = newsItem.source;
    _replyLabel.text = [NSString stringWithFormat:@"%zd", newsItem.replyCount];
    
    NSInteger index = 0;
    for (NSDictionary *dict in newsItem.imgextra) {
        
        NSURL *url = [NSURL URLWithString:dict[@"imgsrc"]];
        
        UIImageView *iv = _extraIcon[index++];
        
        [iv sd_setImageWithURL:url];
    }
    
}
@end
