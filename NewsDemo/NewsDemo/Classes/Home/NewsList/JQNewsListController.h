//
//  JQNewsListController.h
//  NewsDemo
//
//  Created by maoge on 16/10/25.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JQNewsListController : UIViewController

//频道Id
@property (nonatomic, copy, readonly) NSString *channelId;

//数组下标
@property (nonatomic, assign) NSInteger channelIndex;

//指定构造函数
- (instancetype)initWithChannelId:(NSString *)channelId index:(NSInteger)index;

@end
