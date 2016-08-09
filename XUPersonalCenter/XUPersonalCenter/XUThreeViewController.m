//
//  XUThreeViewController.m
//  XUPersonalCenter
//
//  Created by YZJ on 16/6/3.
//  Copyright © 2016年 xiao_u. All rights reserved.
//

#import "XUThreeViewController.h"
#import "UIView+Frame.h"
#import "UIImage+Image.h"

#define XUHeadViewH 200
#define XUHeadViewMinH 64
#define XUSwitchBarH 44


@interface XUThreeViewController ()

@property (nonatomic, assign) CGFloat lastOffsetY;

@end

@implementation XUThreeViewController

static NSString * const reuseIdentifier = @"haah";

-(id)init{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    if (self=[super initWithCollectionViewLayout:layout]) {
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 15;
    layout.minimumInteritemSpacing = 15;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake((self.view.width-60)/3, (self.view.width-60)/3 * 0.7);
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    NSLog(@"%@", [self.view.superclass class]);
    
    _lastOffsetY = -(XUHeadViewH + XUSwitchBarH);
    self.collectionView.contentInset = UIEdgeInsetsMake(XUHeadViewH + XUSwitchBarH , 0, 0, 0);
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(15, 15, 0, 15);
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
