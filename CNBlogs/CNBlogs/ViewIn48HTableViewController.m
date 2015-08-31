//
//  ViewIn48HTableViewController.m
//  CNBlogs
//
//  Created by 李远超 on 15/8/27.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "ViewIn48HTableViewController.h"
#import "ProtocolUtil.h"
#import "BlogModel.h"
#import "BlogTableViewCell.h"
#import "BlogViewController.h"
#import <MJRefresh/MJRefresh.h>

@interface ViewIn48HTableViewController ()

@property (nonatomic, strong) NSArray *blogModelArray;

@end

@implementation ViewIn48HTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;

    [self.tableView registerNib:[UINib nibWithNibName:@"BlogTableViewCell" bundle:nil] forCellReuseIdentifier:@"BlogTableViewCell"];

    __weak ViewIn48HTableViewController *weakSelf = self;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestBlogData];
    }];

    [self.tableView.header beginRefreshing];
}

- (void)requestBlogData {
    [ProtocolUtil getViewIn48HListWithCount:@(20) success:^(id data, id identifier) {
        [self.tableView.header endRefreshing];
        self.blogModelArray = data;
        [self.tableView reloadData];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [self.tableView.header endRefreshing];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.blogModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BlogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BlogTableViewCell" forIndexPath:indexPath];
    BlogModel *model = self.blogModelArray[indexPath.row];
    cell.titleLabel.text = model.title;
    cell.summaryLabel.text = model.summary;
    cell.authorLabel.text = model.author.name;
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

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.didSelectBlogBlock) {
        BlogModel *model = self.blogModelArray[indexPath.row];
        self.didSelectBlogBlock(self, model);
    }
}

@end
