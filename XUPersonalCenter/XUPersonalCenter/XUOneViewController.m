//
//  XUOneViewController.m
//  XUPersonalCenter
//
//  Created by YZJ on 16/6/2.
//  Copyright © 2016年 xiao_u. All rights reserved.
//

#import "XUOneViewController.h"

@interface XUOneViewController ()

@end

@implementation XUOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInterface];
}

#pragma mark - Pravite methods

- (void)setupInterface {
    self.tableView.backgroundColor = [UIColor blueColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

#pragma mark - Setters & Getters

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.backgroundColor = [UIColor brownColor];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

@end
