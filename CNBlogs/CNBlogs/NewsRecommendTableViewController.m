//
//  NewsRecommendTableViewController.m
//  CNBlogs
//
//  Created by 李远超 on 15/8/28.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "NewsRecommendTableViewController.h"
#import "ProtocolUtil.h"
#import "NewsModel.h"
#import "NewsTableViewCell.h"
#import <MJRefresh/MJRefresh.h>

@interface NewsRecommendTableViewController ()

@property (nonatomic, strong) NSMutableArray *newsModelArray;
@property (nonatomic, assign) NSInteger pageIndex;

@end

@implementation NewsRecommendTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;

    [self.tableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsTableViewCell"];

    __weak NewsRecommendTableViewController *weakSelf = self;
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
    [ProtocolUtil getNewsRecommendListWithPageIndex:@(self.pageIndex) pageCount:@(PageCount) success:^(id data, id identifier) {
        self.pageIndex++;
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        NSArray *array = data;
        [self.newsModelArray addObjectsFromArray:array];
        self.tableView.footer.hidden = array.count < PageCount;
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
    cell.publishedLabel.text = [model.published stringWithFormate:yyMMddHHmm];
    cell.diggLabel.text = [model.diggs stringValue];
    cell.viewLabel.text = [model.views stringValue];
    cell.commentLabel.text = [model.comments stringValue];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.didSelectNewsBlock) {
        NewsModel *model = self.newsModelArray[indexPath.row];
        self.didSelectNewsBlock(self, model);
    }
}

@end
