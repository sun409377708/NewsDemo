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
    NSInteger index = 0;
    
    for (JQChannel *channel in channelList) {
        
        JQChannelLabel *l = [JQChannelLabel channelLabelWithTitle:channel.tname];
        
        l.userInteractionEnabled = YES;
        
        l.frame = CGRectMake(x, 0, l.bounds.size.width, height);
        
        //设置tag值
        l.tag = index++;
        
        // x 偏移
        x += l.bounds.size.width + margin;
        
        //label添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        
        [l addGestureRecognizer:tap];
        
        [self.scrollView addSubview:l];
    }
    
    _scrollView.contentSize = CGSizeMake(x, height);
    
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    //设置标签为0的label为1
    [self changeLabelWithIndex:0 scale:1.0];
    
}

- (void)tapGesture:(UITapGestureRecognizer *)recognizer {

    JQChannelLabel *label = (JQChannelLabel *)recognizer.view;
    
    _selectedIndex = label.tag;
    
    //代理通知控制器
    if ([self.delegate respondsToSelector:@selector(channelView:didSelectedIndex:)]) {
        
        [self.delegate channelView:self didSelectedIndex:label.tag];
    }
}

//改变字体大小
- (void)changeLabelWithIndex:(NSInteger)index scale:(float)scale {
    
    JQChannelLabel *label = _scrollView.subviews[index];
    
    label.scale = scale;
}


@end
