//
//  NSString+Path.h
//  断点续传
//
//  Created by maoge on 16/10/22.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Path)

/// 拼接Document目录
- (NSString *)jq_appendDocumentDir;

/// 拼接Cache目录
- (NSString *)jq_appendCacheDir;

/// 拼接temp临时目录
- (NSString *)jq_appendTempDir;

@end
