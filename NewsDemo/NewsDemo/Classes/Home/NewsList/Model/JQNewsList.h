//
//  JQNewsList.h
//  NewsDemo
//
//  Created by maoge on 16/10/26.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JQNewsList : NSObject
/**
 * 标题
 */
@property (nonatomic, copy) NSString *title;
/**
 * 新闻摘要
 */
@property (nonatomic, copy) NSString *digest;
/**
 * 图像 URL 地址
 */
@property (nonatomic, copy) NSString *imgsrc;
/**
 * 跟帖数量
 */
@property (nonatomic, assign) NSInteger replyCount;
/**
 * 来源
 */
@property (nonatomic, copy) NSString *source;

/**
 * 多图新闻的其余图片
 */
@property (nonatomic, strong) NSArray *imgextra;

/**
 * 是否大图标记
 */
@property (nonatomic, assign) BOOL imgType;

/**
 * 是否是顶部 Cell
 */
@property (nonatomic, assign) BOOL hasHead;

@end
