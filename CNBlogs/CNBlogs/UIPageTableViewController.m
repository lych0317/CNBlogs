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
    self.tableView.footer.hidden = YES;
    self.tableView.footer.automaticallyHidden = NO;
}

- (void)successRequestData:(NSArray *)array {
    if (self.pageIndex == 1) {
        self.dataArray = [NSMutableArray array];
        [self.tableView reloadData];
    }
    self.pageIndex++;
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];
    [self.dataArray addObjectsFromArray:array];
    self.tableView.footer.hidden = array.count < PageCount;
    [self.tableView reloadData];
}

- (void)failureRequestData:(NSError *)error {
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];
    [AppUtil showToastWithTitle:error.userInfo[NSLocalizedDescriptionKey]];
    MyLogInfo(@"%@\n%@", NSStringFromClass([self class]), error.description);
}

- (void)requestDataForHeader {
    self.pageIndex = 1;
    [self requestDataWithSuccess:^(NSArray *array) {
        [self successRequestData:array];
    } failure:^(NSError *error) {
        [self failureRequestData:error];
    }];
}

- (void)requestDataForFooter {
    [self requestDataWithSuccess:^(NSArray *array) {
        [self successRequestData:array];
    } failure:^(NSError *error) {
        [self failureRequestData:error];
    }];
}

- (void)requestDataWithSuccess:(PageTableRequestDataSuccessBlock)success failure:(PageTableRequestDataFailureBlock)failure {
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

@end
