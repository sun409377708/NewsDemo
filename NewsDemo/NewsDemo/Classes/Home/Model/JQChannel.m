//
//  JQChannel.m
//  NewsDemo
//
//  Created by maoge on 16/10/26.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import "JQChannel.h"

@implementation JQChannel

+ (NSArray *)channelList {
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"topic_news.json" withExtension:nil];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    //反序列化
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    
    NSArray *array = dict[@"tList"];
    
    NSArray *modelArray = [NSArray yy_modelArrayWithClass:[self class] json:array];
    
    //数组排序
    NSArray *result = [modelArray sortedArrayUsingComparator:^NSComparisonResult(  JQChannel *obj1,  JQChannel *obj2) {
       
        return [obj1.tid compare:obj2.tid];
    }];
    
    return result;
}

- (NSString *)description {
    
    return [self yy_modelDescription];
}

@end
