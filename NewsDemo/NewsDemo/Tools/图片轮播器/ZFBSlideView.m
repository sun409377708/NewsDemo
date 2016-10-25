//
//  ZFBSlideView.m
//  刀哥轮播器
//
//  Created by maoge on 16/8/24.
//  Copyright © 2016年 maoge. All rights reserved.
//

#import "ZFBSlideView.h"
#import "CZAdditions.h"
#import "Masonry.h"
#import "ZFBSlideCell.h"

//放大基数
#define kDataScaleSeed 1000

//类中类
@interface FlowLayout: UICollectionViewFlowLayout


@end

@implementation FlowLayout

- (void)prepareLayout {
    
    [super prepareLayout];
    
    self.itemSize = self.collectionView.bounds.size;
    
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

@end

static NSString *identifier = @"colleciton";

@interface ZFBSlideView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, weak) NSTimer *timer;

@property (nonatomic, assign) NSTimeInterval timeInterval;

@property (nonatomic, weak) UIPageControl *pControl;

@end

@implementation ZFBSlideView

- (void)awakeFromNib {
    
    [self setupUI];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setImageUrls:(NSArray *)imageUrls {
    _imageUrls = imageUrls;
    
    [_collectionView reloadData];
    
    
    //设置初始位置, 位于中间
//    CGFloat width = _collectionView.bounds.size.width;
//    CGFloat offsetX = _imageUrls.count * width;
//    
//    _collectionView.contentOffset = CGPointMake(offsetX, 0);
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_imageUrls.count * kDataScaleSeed inSection:0];
    
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    //pageControl赋值
    _pControl.numberOfPages = imageUrls.count;
    
    
    _timeInterval = 2.0;
    //创建定时器
    NSTimer *timer = [NSTimer timerWithTimeInterval:_timeInterval target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    _timer = timer;
}

- (void)setupUI {
    
    //创建collectionView
    
    FlowLayout *layout = [[FlowLayout alloc] init];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    
    [collectionView registerClass:[ZFBSlideCell class] forCellWithReuseIdentifier:identifier];
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    collectionView.pagingEnabled = YES;
    
    collectionView.bounces = NO;
    
    [self addSubview:collectionView];
    
    _collectionView = collectionView;
    
    //创建UIPageControl
    
    UIPageControl *pControl = [[UIPageControl alloc] init];
    
    pControl.pageIndicatorTintColor = [UIColor blackColor];
    pControl.currentPageIndicatorTintColor = [UIColor orangeColor];

    [self addSubview:pControl];

    //开始约束
//    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.edges.equalTo(self);
//    }];
    
    [pControl mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self);
        make.bottom.mas_equalTo(-4);
    }];
    
    _pControl = pControl;
}

#pragma  mark - 定时器相关方法
//定时器方法
- (void)nextPage {
    //开始向右偏移
    
    //第一种方法
//    CGFloat offsetX = _collectionView.contentOffset.x + _collectionView.bounds.size.width;
//
//    [_collectionView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    // view 的 window 属性，表示视图当前显示所在的窗口，如果视图不显示，window 为 nil
    // 判断 window 是否为 nil，不执行后续的时钟代码
    if (self.window == nil) {
        return;
    }
    
    //第二种方法
    NSIndexPath *visiableIndex = [_collectionView indexPathsForVisibleItems].lastObject;
    
    NSIndexPath *newIndex = [NSIndexPath indexPathForItem:visiableIndex.item + 1 inSection:visiableIndex.section];
    
    [_collectionView scrollToItemAtIndexPath:newIndex atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

//自动滚动停止后调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    [self scrollViewDidEndDecelerating:scrollView];
}


//开始拖拽, 将定时器时间设为最大
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    _timer.fireDate = [NSDate distantFuture];
    
    NSLog(@"%@", [NSDate distantFuture]);
}

//停止拖拽时, 2s后启动定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    _timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:_timeInterval];
}

#pragma  mark - UICollectionView - DataSource Method

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _imageUrls.count * kDataScaleSeed * 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZFBSlideCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor cz_randomColor];
    
    //数据只能取小于数组个数
    NSInteger index = indexPath.item % _imageUrls.count;
    
    cell.Urls = _imageUrls[index];
    
    return  cell;
}

#pragma  mark - UIScrollView - Delegate Method

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    //获取数组最后一个与第0个
    
    //lastItem  _imageUrls.count * 2
    NSInteger lastItem = [_collectionView numberOfItemsInSection:0];
    
    if (page == 0 || page == (lastItem - 1)) {
        
        //第0页, 跳到_imageUrls.count
        //最后一页, 调到_imageUrls.count - 1
        
        NSInteger imageCount = _imageUrls.count * kDataScaleSeed;
        
        CGFloat width = scrollView.bounds.size.width;
        
        if (page == (lastItem - 1)) {
            imageCount = imageCount - 1;
        }
        
        scrollView.contentOffset = CGPointMake(imageCount * width, 0);
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    NSInteger pageNo = (NSInteger)(page + 0.5);
    
//    NSLog(@"%ld", pageNo);
    
    pageNo = pageNo % _imageUrls.count;
    
    _pControl.currentPage = pageNo;
}

- (void)dealloc {
    
    NSLog(@"销毁");
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    
    [_timer invalidate];
}

@end
