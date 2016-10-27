//
//  JQChannelLabel.m
//  NewsDemo
//
//  Created by maoge on 16/10/27.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import "JQChannelLabel.h"

#define kNormalSize 14
#define kSelectedSize 18

@implementation JQChannelLabel

+ (instancetype)channelLabelWithTitle:(NSString *)title {
    
    //先用大尺寸将位置撑出来, 然后再设置小字体
    JQChannelLabel *l = [self cz_labelWithText:title fontSize:kSelectedSize color:[UIColor blackColor]];
    
    l.font = [UIFont systemFontOfSize:kNormalSize];
    
    l.textAlignment = NSTextAlignmentCenter;
    
    return l;
}

@end
