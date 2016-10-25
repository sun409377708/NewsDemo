//
//  NSString+Path.m
//  断点续传
//
//  Created by maoge on 16/10/22.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import "NSString+Path.h"

@implementation NSString (Path)

- (NSString *)jq_appendDocumentDir {
    
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    
    return [dir stringByAppendingPathComponent:self.lastPathComponent];
}

- (NSString *)jq_appendCacheDir {
    
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    
    return [dir stringByAppendingPathComponent:self.lastPathComponent];
}

- (NSString *)jq_appendTempDir {
    
    NSString *dir = NSTemporaryDirectory();
    
    return [dir stringByAppendingPathComponent:self.lastPathComponent];
}

@end
