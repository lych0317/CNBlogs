//
//  UIBaseViewController.m
//  CNBlogs
//
//  Created by 李远超 on 15/9/7.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "UIBaseViewController.h"

@interface UIBaseViewController ()

@end

@implementation UIBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
