//
//  JQNetworkManager.h
//  NewsDemo
//
//  Created by maoge on 16/10/26.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import <AFHTTPSessionManager.h>

@interface JQNetworkManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

- (void)newsListWithChannel:(NSString *)channel start:(NSInteger)start completion:(void(^)(NSArray *array, NSError *error))completion;

@end
