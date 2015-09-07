//
//  UIPageTableViewController.m
//  CNBlogs
//
//  Created by 李远超 on 15/9/7.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "UIPageTableViewController.h"

@interface UIPageTableViewController ()

@end

@implementation UIPageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak UIPageTableViewController *weakSelf = self;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestDataForHeader];
    }];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestDataForFooter];
    }];

    self.successBlock = ^(id data, id identifier) {
        if (weakSelf.pageIndex == 1) {
            weakSelf.dataArray = [NSMutableArray array];
            [weakSelf.tableView reloadData];
        }
        weakSelf.pageIndex++;
        [weakSelf.tableView.header endRefreshing];
        [weakSelf.tableView.footer endRefreshing];
        NSArray *array = data;
        [weakSelf.dataArray addObjectsFromArray:array];
        weakSelf.tableView.footer.hidden = array.count < PageCount;
        [weakSelf.tableView reloadData];
    };
    self.failureBlock = ^(RKObjectRequestOperation *operation, NSError *error) {
        [weakSelf.tableView.header endRefreshing];
        [weakSelf.tableView.footer endRefreshing];
        [AppUtil showToastWithTitle:error.userInfo[NSLocalizedDescriptionKey]];
        MyLogInfo(@"%@\n%@", NSStringFromClass([weakSelf class]), error.description);
    };
}

- (void)requestDataForHeader {
    self.pageIndex = 1;
    [self requestData];
}

- (void)requestDataForFooter {
    [self requestData];
}

- (void)requestData {
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

@end
