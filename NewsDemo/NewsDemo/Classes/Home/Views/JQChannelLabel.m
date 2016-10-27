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

- (void)setScale:(float)scale {
    _scale = scale;
    
    //目的: scale在0 ~ 1之间  让label的字体由14 - 18 之间渐变
    
    float min = 1;
    float max = (float)kSelectedSize / kNormalSize;
    
    float s = (max - 1) * scale + min;
    
    self.transform = CGAffineTransformMakeScale(s, s);
    
    //设置字体颜色
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1.0];
}

@end
