//
//  JQChannelLabel.h
//  NewsDemo
//
//  Created by maoge on 16/10/27.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JQChannelLabel : UILabel

+ (instancetype)channelLabelWithTitle:(NSString *)title;

//缩放比例大小
@property (nonatomic, assign) float scale;

@end
