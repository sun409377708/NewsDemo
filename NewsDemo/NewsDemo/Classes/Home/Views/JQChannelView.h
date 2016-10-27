//
//  JQChannelView.h
//  NewsDemo
//
//  Created by maoge on 16/10/26.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JQChannel;

@interface JQChannelView : UIView

+ (instancetype)channelView;

@property (nonatomic, strong) NSArray <JQChannel *>*channelList;

- (void)changeLabelWithIndex:(NSInteger)index scale:(float)scale;

@end
