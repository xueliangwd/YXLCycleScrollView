//
//  ViewController.m
//  YXLCycleScrollView
//
//  Created by 于学良 on 2017/11/16.
//  Copyright © 2017年 yxlGitHub. All rights reserved.
//

#import "ViewController.h"
#import "YXLCycleScrollView.h"
@interface ViewController ()<YXLCycleScrollViewDelegate>{
    YXLCycleScrollView * scr;
}
@end

@implementation ViewController
-(void)viewWillAppear:(BOOL)animated{
    [scr addVCWillAppear];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    scr = [[YXLCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200.0)];
    scr.delegate = self;
    scr.localImgArray = @[[UIImage imageNamed:@"banner1.jpg"],[UIImage imageNamed:@"banner2.jpg"],[UIImage imageNamed:@"banner3.jpg"]];
    [self.view addSubview:scr];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark CycleDelegate
-(void)clickBannerWithIndex:(NSInteger)index{
    NSLog(@"click index is %ld",index);
}
@end
