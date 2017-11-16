//
//  YXLCycleScrollView.m
//  YXLCycleScrollView
//
//  Created by 于学良 on 2017/11/16.
//  Copyright © 2017年 yxlGitHub. All rights reserved.
//

#import "YXLCycleScrollView.h"
@interface YXLCycleScrollView ()<UIScrollViewDelegate>{
    UIScrollView *_contentScrollView;
    UIPageControl *_pageControl;

    UIImageView *_leftImgView;
    UIImageView *_middleImgView;
    UIImageView *_rightImgView;

    NSInteger *_currentPageIndex;

    NSTimer *_outoCycleTimer;
}
@end

@implementation YXLCycleScrollView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

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
    _contentScrollView.backgroundColor = [UIColor clearColor];
    _contentScrollView.delegate = self;
    [self addSubview:_contentScrollView];

    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, temHight-30, temWith, 30.0)];
    [self addSubview:_pageControl];

    _leftImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, temWith, temHight)];
    _middleImgView = [[UIImageView alloc]initWithFrame:CGRectMake(temWith, 0, temWith, temHight)];
    _rightImgView = [[UIImageView alloc]initWithFrame:CGRectMake(temWith*2, 0, temWith, temHight)];
    [_contentScrollView addSubview:_leftImgView];
    [_contentScrollView addSubview:_middleImgView];
    [_contentScrollView addSubview:_rightImgView];
}
#pragma mark PrivateMethod
-(void)startTimer{

}
-(void)stopTimer{

}
#pragma mark --UIScrollViewDelegate

@end
