//
//  XUPersonalCenterViewController.m
//  XUPersonalCenter
//
//  Created by YZJ on 16/6/2.
//  Copyright © 2016年 xiao_u. All rights reserved.
//

#import "XUPersonalCenterViewController.h"
#import "XUOneViewController.h"
#import "XUTwoViewController.h"
#import "XUThreeViewController.h"
#import "UIView+Frame.h"

@interface XUPersonalCenterViewController ()

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *headContentView;
@property (weak, nonatomic) IBOutlet UIView *switchBarView;
@property (weak, nonatomic) IBOutlet UIImageView *personCardView;
@property (weak, nonatomic) IBOutlet UIImageView *personIconView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headViewCons;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, weak) UIButton *selectedButton;
@property (nonatomic, strong) UIView *indicatorView;

@end

@implementation XUPersonalCenterViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInterface];
    [self.switchBarView addSubview:self.indicatorView];
    [self setupChildController];
    [self layoutSwitchBar];
}

#pragma mark - Pravite methods

- (void)setupInterface {
    self.view.backgroundColor = [UIColor brownColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    self.navigationItem.titleView = self.titleLabel;
}

- (void)layoutSwitchBar {
    CGFloat width = self.switchBarView.width / self.childViewControllers.count;
    CGFloat height = self.switchBarView.height;
    for (NSInteger i = 0; i < self.childViewControllers.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.frame = CGRectMake(i * width, 0, width, height);
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.switchBarView addSubview:button];
        if (i == 0) {
            [self switchAction:button];
            button.enabled = NO;
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
}

- (void)setupChildController {
    XUOneViewController *oneVc = [[XUOneViewController alloc] init];
    oneVc.title = @"第一个";
    oneVc.headHCons = _headViewCons;
    oneVc.titleLabel = _titleLabel;
    [self addChildViewController:oneVc];
    
    XUTwoViewController *twoVc = [[XUTwoViewController alloc] init];
    twoVc.title = @"第二个";
    twoVc.headHCons = _headViewCons;
    twoVc.titleLabel = _titleLabel;
    [self addChildViewController:twoVc];
    
    XUThreeViewController *threeVc = [[XUThreeViewController alloc] init];
    threeVc.title = @"第三个";
    threeVc.headHCons = _headViewCons;
    threeVc.titleLabel = _titleLabel;
    [self addChildViewController:threeVc];
}

#pragma mark - Actions

- (void)switchAction:(UIButton *)sender {
    if (sender == self.selectedButton) return;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = sender.titleLabel.width;
        self.indicatorView.centerX = sender.centerX;
    }];
    
    NSLog(@"%ld", self.selectedButton.tag);
    UIViewController *lastVc = self.childViewControllers[self.selectedButton.tag];

    [lastVc.view removeFromSuperview];

    CGPoint contentOffset = CGPointMake(0, 0);
    if ([lastVc isKindOfClass:[UITableViewController class]]) {
        UITableViewController *lastTableVc = (UITableViewController *)lastVc;
        contentOffset = lastTableVc.tableView.contentOffset;
    }else if ([lastVc isKindOfClass:[UICollectionViewController class]]){
        UICollectionViewController *lastCollectionVc = (UICollectionViewController *)lastVc;
        contentOffset = lastCollectionVc.collectionView.contentOffset;
    }
    if (contentOffset.y > -108) {
        contentOffset = CGPointMake(0, -108);
    }
    NSLog(@"%f",contentOffset.y);
    
    self.selectedButton.enabled = YES;
    sender.enabled = NO;
    self.selectedButton = sender;
    
    UIViewController *vc = self.childViewControllers[sender.tag];
    
    if ([vc isKindOfClass:[UITableViewController class]]) {
        UITableViewController *tableVc = (UITableViewController *)vc;
        tableVc.view.frame = _contentView.bounds;
        tableVc.tableView.contentOffset = contentOffset;
        [self.contentView addSubview:tableVc.view];
    }else if ([vc isKindOfClass:[UICollectionViewController class]]) {
        UICollectionViewController *collectionVc = (UICollectionViewController *)vc;
        collectionVc.collectionView.frame = _contentView.bounds;
        collectionVc.collectionView.contentOffset = contentOffset;
        NSLog(@"%f", collectionVc.collectionView.contentOffset.y);
        [self.contentView addSubview:collectionVc.collectionView];
    }
}

#pragma mark - Setters & Getters

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.text = self.title;
        _titleLabel.textColor = [UIColor colorWithWhite:1 alpha:0];
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (UIView *)indicatorView {
    if (_indicatorView == nil) {
        _indicatorView = [[UIView alloc] init];
        _indicatorView.frame = CGRectMake(0, self.switchBarView.frame.size.height - 2, 0, 2);
        _indicatorView.backgroundColor = [UIColor redColor];
    }
    return _indicatorView;
}


@end
