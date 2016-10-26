//
//  JQNetworkManager.m
//  NewsDemo
//
//  Created by maoge on 16/10/26.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import "JQNetworkManager.h"

@implementation JQNetworkManager

+ (instancetype)sharedManager {
    
    static JQNetworkManager *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURL *baseURL = [NSURL URLWithString:@"http://c.m.163.com/nc/article/"];
        
        instance = [[self alloc] initWithBaseURL:baseURL];
        
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];

    });
    
    return instance;
}

#pragma mark -
#pragma mark 网易新闻接口
- (void)newsListWithChannel:(NSString *)channel start:(NSInteger)start completion:(void (^)(NSArray *array, NSError *error))completion {
    
    NSString *urlString = [NSString stringWithFormat:@"list/%@/%zd-20.html", channel, start];
    
    [self GETRuquest:urlString parameter:nil completion:^(id json, NSError *error) {
        
        NSArray *array = json[channel];
        
        completion(array, nil);
    }];
}



//GET请求
- (void)GETRuquest:(NSString *)urlString parameter:(NSDictionary *)parameter completion:(void(^)(id json, NSError *error))completion {
    
    [self GET:urlString parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        completion(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        completion(nil, error);
    }];
}

@end
