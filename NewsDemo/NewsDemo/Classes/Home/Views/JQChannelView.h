//
//  JQChannelView.h
//  NewsDemo
//
//  Created by maoge on 16/10/26.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JQChannel, JQChannelView;

@protocol JQChannelViewDelegate <NSObject>

- (void)channelView:(JQChannelView *)channelView didSelectedIndex:(NSInteger)index;

@end

@interface JQChannelView : UIView

+ (instancetype)channelView;

@property (nonatomic, strong) NSArray <JQChannel *>*channelList;

- (void)changeLabelWithIndex:(NSInteger)index scale:(float)scale;

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, weak) id <JQChannelViewDelegate>delegate;

@end
