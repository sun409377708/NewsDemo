//
//  NSString+Base64.h
//  加密登陆
//
//  Created by maoge on 16/10/19.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64)

//base64编码
- (NSString *)jq_base64Encode;

//base64解码
- (NSString *)jq_base64Decode;

@end
