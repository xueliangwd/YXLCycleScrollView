//
//  YXLCycleScrollView.m
//  YXLCycleScrollView
//
//  Created by 于学良 on 2017/11/16.
//  Copyright © 2017年 yxlGitHub. All rights reserved.
//

#define CALCULINDEX(currentIndex,pageTotalCount) (currentIndex+pageTotalCount)%pageTotalCount
#import "YXLCycleScrollView.h"
@interface YXLCycleScrollView ()<UIScrollViewDelegate>{
    UIScrollView *_contentScrollView;
    UIPageControl *_pageControl;

    NSInteger _currentPageIndex;
    NSTimer *_outoCycleTimer;
    NSArray *_imageViewsArray;
}
@end

@implementation YXLCycleScrollView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

-(void)initialization{
    _currentPageIndex = 0;
    NSInteger temWith = self.bounds.size.width;
    NSInteger temHight = self.bounds.size.height;
    _contentScrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    _contentScrollView.contentSize = CGSizeMake(temWith*3, temHight);
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.showsVerticalScrollIndicator = NO;
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.backgroundColor = [UIColor clearColor];
    _contentScrollView.contentOffset = CGPointMake(_contentScrollView.frame.size.width, 0);
    _contentScrollView.delegate = self;
    [self addSubview:_contentScrollView];
    UITapGestureRecognizer *bannerTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bannerClickAction)];
    [self addGestureRecognizer:bannerTap];

    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, temHight-30, temWith, 30.0)];
    _pageControl.currentPage = _currentPageIndex;
    [self addSubview:_pageControl];
    NSMutableArray *temArr = [NSMutableArray array];
    for (int i=0; i<3; i++) {
        UIImageView* imgView = [[UIImageView alloc]initWithFrame:CGRectMake(temWith*i,0, temWith, temHight)];
        [_contentScrollView addSubview:imgView];
        [temArr addObject:imgView];
    }
    _imageViewsArray = [temArr copy];
}
#pragma mark AddWillAppear
-(void)addVCWillAppear{
    //处理 轮播出现半屏问题 在VC willAppear处调用
    int offSetX = _contentScrollView.contentOffset.x;
    int width = _contentScrollView.frame.size.width;
    if (offSetX%width != 0) {
        [self stopTimer];
        [self configImageView];
        _contentScrollView.contentOffset = CGPointMake(width, 0.0);
        [self startTimer];
    }
}
#pragma mark SetterMethods
-(void)setLocalImgArray:(NSArray *)localImgArray{
    _localImgArray = [localImgArray copy];
    _pageControl.numberOfPages = _localImgArray.count;
    [self configImageView];
    [self startTimer];
}
#pragma mark PrivateMethod
-(void)bannerClickAction{
    if ([self.delegate respondsToSelector:@selector(clickBannerWithIndex:)]) {
        [self.delegate clickBannerWithIndex:_currentPageIndex];
    }
}
-(void)configImageView{
    if (_localImgArray.count == 0) {
        return;
    }
    for (int i=0;i<3;i++) {
        UIImageView *imageView = _imageViewsArray[i];
        imageView.image = _localImgArray[CALCULINDEX(_currentPageIndex+i-1, _localImgArray.count)];
    }
}
-(void)startTimer{
    if (![_outoCycleTimer isValid]) {
        _outoCycleTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(autoCycleAnimation) userInfo:nil repeats:YES];
        //加到mainRunloop 防止timer失效
        [[NSRunLoop mainRunLoop] addTimer:_outoCycleTimer forMode:NSRunLoopCommonModes];
    }
}
-(void)stopTimer{
    [_outoCycleTimer invalidate];
    _outoCycleTimer = nil;
}
-(void)autoCycleAnimation{
    if (_localImgArray.count == 0) {
        return;
    }
    _currentPageIndex = CALCULINDEX(_currentPageIndex+1, _localImgArray.count);
    _pageControl.currentPage = _currentPageIndex;
    [_contentScrollView setContentOffset:CGPointMake(2.0*_contentScrollView.frame.size.width, 0) animated:YES];
    //该处重置位置，也可实现无限自动轮播，但页面切换后会出现错乱问题
//    [self configImageView];
//    _contentScrollView.contentOffset = CGPointMake(0, 0);
}
#pragma mark --UIScrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //拖动时 停止自动轮播
    [self stopTimer];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //拖动结束 开始轮播
    [self startTimer];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // 每滚动一页 重置ImageView scrollInset pageIndex
    CGPoint offset = [_contentScrollView contentOffset];
    if (offset.x == 2*_contentScrollView.frame.size.width) {
        _currentPageIndex = CALCULINDEX(_currentPageIndex + 1,_localImgArray.count);
    } else if (offset.x == 0){
        _currentPageIndex = CALCULINDEX(_currentPageIndex - 1,_localImgArray.count);
    }else{
        return;
    }

    _pageControl.currentPage = _currentPageIndex;
    [self configImageView];
    [_contentScrollView setContentOffset:CGPointMake(_contentScrollView.frame.size.width, 0)];
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //自动滚动动画结束 重置位置
    [self configImageView];
    _contentScrollView.contentOffset = CGPointMake(_contentScrollView.frame.size.width, 0);
}
@end
