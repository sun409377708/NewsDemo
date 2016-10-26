//
//  JQChannelView.m
//  NewsDemo
//
//  Created by maoge on 16/10/26.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import "JQChannelView.h"

@interface JQChannelView ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end

@implementation JQChannelView

+ (instancetype)channelView {
    
    UINib *nib = [UINib nibWithNibName:@"JQChannelView" bundle:nil];
    
    return [nib instantiateWithOwner:nil options:nil].lastObject;
}

@end
