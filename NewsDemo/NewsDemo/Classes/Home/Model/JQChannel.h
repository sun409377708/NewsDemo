//
//  JQChannel.h
//  NewsDemo
//
//  Created by maoge on 16/10/26.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JQChannel : NSObject

//新闻名
@property (nonatomic, copy) NSString *tname;

//新闻ID
@property (nonatomic, copy) NSString *tid;

+ (NSArray *)channelList;

@end
