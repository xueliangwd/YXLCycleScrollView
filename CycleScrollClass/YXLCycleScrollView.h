//
//  YXLCycleScrollView.h
//  YXLCycleScrollView
//  简单无限轮播，三个ImageView方案
//  轮播单个banner太复杂时，会有闪的问题
//  轮播半屏问题，在willAppear调用 addVCWillAppear
//  Created by 于学良 on 2017/11/16.
//  Copyright © 2017年 yxlGitHub. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YXLCycleScrollViewDelegate<NSObject>
@optional
-(void)clickBannerWithIndex:(NSInteger)index;
@end
@interface YXLCycleScrollView : UIView{
    
}
@property(nonatomic,assign)id<YXLCycleScrollViewDelegate>delegate;
@property(nonatomic,copy)NSArray *localImgArray;
//处理 轮播出现半屏问题 在VC willAppear处调用
-(void)addVCWillAppear;
@end
