//
//  ZFBSlideCell.m
//  刀哥轮播器
//
//  Created by maoge on 16/8/24.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import "ZFBSlideCell.h"

@interface ZFBSlideCell ()

@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation ZFBSlideCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setUrls:(NSURL *)Urls {
    _Urls = Urls;
    
    NSData *data = [NSData dataWithContentsOfURL:Urls];
    
    UIImage *image = [UIImage imageWithData:data];
    
    _imageView.image = image;
    
}

- (void)setupUI {
    
    //添加ImageView
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    
    imageView.backgroundColor = [UIColor yellowColor];
    
    [self.contentView addSubview:imageView];
    
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    imageView.clipsToBounds = YES;
    
    _imageView = imageView;
}

@end
