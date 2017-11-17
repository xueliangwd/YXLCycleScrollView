//
//  ViewController.m
//  YXLCycleScrollView
//
//  Created by 于学良 on 2017/11/16.
//  Copyright © 2017年 yxlGitHub. All rights reserved.
//

#import "ViewController.h"
#import "YXLCycleScrollView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    YXLCycleScrollView * scr = [[YXLCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200.0)];
    scr.localImgArray = @[[UIImage imageNamed:@"banner1.jpg"],[UIImage imageNamed:@"banner2.jpg"],[UIImage imageNamed:@"banner3.jpg"]];
    [self.view addSubview:scr];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
