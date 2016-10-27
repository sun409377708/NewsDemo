//
//  JQChannelView.m
//  NewsDemo
//
//  Created by maoge on 16/10/26.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import "JQChannelView.h"
#import "JQChannel.h"
#import "JQChannelLabel.h"

@interface JQChannelView ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end

@implementation JQChannelView

+ (instancetype)channelView {
    
    UINib *nib = [UINib nibWithNibName:@"JQChannelView" bundle:nil];
    
    return [nib instantiateWithOwner:nil options:nil].lastObject;
}

- (void)setChannelList:(NSArray<JQChannel *> *)channelList {
    _channelList = channelList;
    
    //设置label的frame
    CGFloat x = 30;
    CGFloat margin = 8;
    CGFloat height = _scrollView.bounds.size.height;
    
    for (JQChannel *channel in channelList) {
        
        JQChannelLabel *l = [JQChannelLabel channelLabelWithTitle:channel.tname];
        
        l.frame = CGRectMake(x, 0, l.bounds.size.width, height);
        
        // x 偏移
        x += l.bounds.size.width + margin;
        
        [self.scrollView addSubview:l];
    }
    
    _scrollView.contentSize = CGSizeMake(x, height);
    
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    //设置标签为0的label为1
    [self changeLabelWithIndex:0 scale:1.0];
    
}

//改变字体大小
- (void)changeLabelWithIndex:(NSInteger)index scale:(float)scale {
    
    JQChannelLabel *label = _scrollView.subviews[index];
    
    label.scale = scale;
}


@end
