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
    
    [_iconView jq_setImageWithURLString:newsItem.imgsrc];
    
    _titleLabel.text = newsItem.title;
    _sourceLabel.text = newsItem.source;
    _replyLabel.text = [NSString stringWithFormat:@"%zd", newsItem.replyCount];
    
    NSInteger index = 0;
    for (NSDictionary *dict in newsItem.imgextra) {
        
        UIImageView *iv = _extraIcon[index++];
        
        [iv jq_setImageWithURLString:dict[@"imgsrc"]];
    }
    
}
@end
