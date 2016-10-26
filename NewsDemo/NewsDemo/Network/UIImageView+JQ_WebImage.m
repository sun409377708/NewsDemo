//
//  UIImageView+JQ_WebImage.m
//  NewsDemo
//
//  Created by maoge on 16/10/26.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import "UIImageView+JQ_WebImage.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (JQ_WebImage)

- (void)jq_setImageWithURLString:(NSString *)urlString {
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    if (url != nil) {
        
        [self sd_setImageWithURL:url];
    }
}

@end
