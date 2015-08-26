//
//  NewsTableViewController.m
//  CNBlogs
//
//  Created by 李远超 on 15/8/26.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "NewsTableViewController.h"
#import "ProtocolUtil.h"
#import "NewsModel.h"
#import "NewsTableViewCell.h"
#import <MJRefresh/MJRefresh.h>

@interface NewsTableViewController ()

@property (nonatomic, strong) NSMutableArray *newsModelArray;
@property (nonatomic, assign) NSInteger pageIndex;

@end

@implementation NewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;

    __weak NewsTableViewController *weakSelf = self;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestNewsDataForHeader];
    }];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestNewsDataForFooter];
    }];

    [self.tableView.header beginRefreshing];
}

- (void)requestNewsDataForHeader {
    self.pageIndex = 1;
    self.newsModelArray = [NSMutableArray array];
    [self.tableView reloadData];
    [self requestNewsData];
}

- (void)requestNewsDataForFooter {
    [self requestNewsData];
}

- (void)requestNewsData {
    [ProtocolUtil getNewsListWithPageIndex:@(self.pageIndex) pageCount:@(PageCount) success:^(id data, id identifier) {
        self.pageIndex++;
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        [self.newsModelArray addObjectsFromArray:data];
        [self.tableView reloadData];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsTableViewCell" forIndexPath:indexPath];
    NewsModel *model = self.newsModelArray[indexPath.row];
    cell.titleLabel.text = model.title;
    cell.summaryLabel.text = model.summary;
    cell.sourceLabel.text = model.sourceName;
    cell.publishedLabel.text = [self stringFromDate:model.published];
    cell.diggLabel.text = [model.diggs stringValue];
    cell.viewLabel.text = [model.views stringValue];
    cell.commentLabel.text = [model.comments stringValue];
    return cell;
}

- (NSString *)stringFromDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yy-MM-dd HH:mm"];
    return [formatter stringFromDate:date];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

@end
