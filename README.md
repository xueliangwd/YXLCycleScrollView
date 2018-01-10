YXLCycleScrollView
============

-  简单无限轮播，三个ImageView方案
-  轮播单个banner太复杂时，会有闪的问题
-  轮播半屏问题，在willAppear调用 addVCWillAppear


## Example
-  头文件引用` #import "YXLCycleScrollView.h" `

```

scr = [[YXLCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200.0)];
scr.delegate = self;
scr.localImgArray = @[[UIImage imageNamed:@"banner1.jpg"],[UIImage imageNamed:@"banner2.jpg"],[UIImage imageNamed:@"banner3.jpg"]];
[self.view addSubview:scr];

```
