//
//  XUShowCollectionViewController.m
//  XUPersonalCenter
//
//  Created by YZJ on 16/6/3.
//  Copyright © 2016年 xiao_u. All rights reserved.
//

#import "XUShowCollectionViewController.h"
#import "UIImage+Image.h"

#define XUHeadViewH 200
#define XUHeadViewMinH 64
#define XUSwitchBarH 44


@interface XUShowCollectionViewController ()

@property (nonatomic, assign) CGFloat lastOffsetY;

@end

@implementation XUShowCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    _lastOffsetY = -(XUHeadViewH + XUSwitchBarH);
    self.collectionView.contentInset = UIEdgeInsetsMake(XUHeadViewH + XUSwitchBarH , 0, 0, 0);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 获取当前偏移量
    CGFloat offsetY = scrollView.contentOffset.y;
    
    // 获取偏移量差值
    CGFloat delta = offsetY - _lastOffsetY;
    
    CGFloat headH = XUHeadViewH - delta;
    
    if (headH < XUHeadViewMinH) {
        headH = XUHeadViewMinH;
    }
    
    _headHCons.constant = headH;
    
    // 计算透明度，刚好拖动200 - 64 136，透明度为1
    
    CGFloat alpha = delta / (XUHeadViewH - XUHeadViewMinH);
    
    // 获取透明颜色
    UIColor *alphaColor = [UIColor colorWithWhite:0 alpha:alpha];
    [_titleLabel setTextColor:alphaColor];
    
    // 设置导航条背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithWhite:1 alpha:alpha]] forBarMetrics:UIBarMetricsDefault];
}




@end
