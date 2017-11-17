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

    UIImageView *_leftImgView;
    UIImageView *_middleImgView;
    UIImageView *_rightImgView;

    NSInteger _currentPageIndex;

    NSTimer *_outoCycleTimer;
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

    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, temHight-30, temWith, 30.0)];
    _pageControl.currentPage = _currentPageIndex;
    [self addSubview:_pageControl];

    _leftImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, temWith, temHight)];
    _middleImgView = [[UIImageView alloc]initWithFrame:CGRectMake(temWith, 0, temWith, temHight)];
    _rightImgView = [[UIImageView alloc]initWithFrame:CGRectMake(temWith*2, 0, temWith, temHight)];
    [_contentScrollView addSubview:_leftImgView];
    [_contentScrollView addSubview:_middleImgView];
    [_contentScrollView addSubview:_rightImgView];
}

#pragma mark SetterMethods
-(void)setLocalImgArray:(NSArray *)localImgArray{
    _localImgArray = [localImgArray copy];
    _pageControl.numberOfPages = _localImgArray.count;
    [self configImageView];
    [self startTimer];
}
#pragma mark PrivateMethod
-(void)configImageView{
    if (_localImgArray.count == 0) {
        return;
    }
    _middleImgView.image = _localImgArray[CALCULINDEX(_currentPageIndex, _localImgArray.count)];
    _leftImgView.image = _localImgArray[CALCULINDEX(_currentPageIndex-1, _localImgArray.count)];
    _rightImgView.image = _localImgArray[CALCULINDEX(_currentPageIndex+1, _localImgArray.count)];
}
-(void)startTimer{
    if (![_outoCycleTimer isValid]) {
        _outoCycleTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(autoCycleAnimation) userInfo:nil repeats:YES];
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
    [self configImageView];
    _contentScrollView.contentOffset = CGPointMake(0, 0);
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

@end
