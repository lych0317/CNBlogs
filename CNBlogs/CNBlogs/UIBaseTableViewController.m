//
//  UIBaseTableViewController.m
//  CNBlogs
//
//  Created by 李远超 on 15/9/7.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "UIBaseTableViewController.h"

@interface UIBaseTableViewController ()

@end

@implementation UIBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;

    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = view;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass([self class])];
    MyLogInfo(@"begin log page view %@", NSStringFromClass([self class]));
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass([self class])];
    MyLogInfo(@"end log page view %@", NSStringFromClass([self class]));
}

@end
