//
//  BloggerTableViewController.m
//  CNBlogs
//
//  Created by 李远超 on 15/8/28.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "BloggerTableViewController.h"
#import "ProtocolUtil.h"
#import "BlogModel.h"
#import "BloggerModel.h"
#import "BlogTableViewCell.h"
#import "BlogViewController.h"
#import <MJRefresh/MJRefresh.h>

@interface BloggerTableViewController ()

@property (nonatomic, strong) NSMutableArray *blogModelArray;
@property (nonatomic, assign) NSInteger pageIndex;

@end

@implementation BloggerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.bloggerModel.title;

    self.clearsSelectionOnViewWillAppear = NO;

    [self.tableView registerNib:[UINib nibWithNibName:@"BlogTableViewCell" bundle:nil] forCellReuseIdentifier:@"BlogTableViewCell"];

    __weak BloggerTableViewController *weakSelf = self;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestBlogDataForHeader];
    }];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestBlogDataForFooter];
    }];

    [self.tableView.header beginRefreshing];
}

- (IBAction)likeBloggerAction:(UIBarButtonItem *)sender {
}

- (void)requestBlogDataForHeader {
    self.pageIndex = 1;
    self.blogModelArray = [NSMutableArray array];
    [self.tableView reloadData];
    [self requestBlogData];
}

- (void)requestBlogDataForFooter {
    [self requestBlogData];
}

- (void)requestBlogData {
    [ProtocolUtil getBlogListWithBlogapp:self.bloggerModel.blogapp pageIndex:@(self.pageIndex) pageCount:@(PageCount) success:^(id data, id identifier) {
        self.pageIndex++;
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        NSArray *array = data;
        [self.blogModelArray addObjectsFromArray:array];
        self.tableView.footer.hidden = array.count < PageCount;
        [self.tableView reloadData];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
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
    cell.publishedLabel.text = [model.published stringWithFormate:yyMMddHHmm];
    cell.diggLabel.text = [model.diggs stringValue];
    cell.viewLabel.text = [model.views stringValue];
    cell.commentLabel.text = [model.comments stringValue];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BlogModel *model = self.blogModelArray[indexPath.row];
    [self performSegueWithIdentifier:@"BloggerToContentSegue" sender:model];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"BloggerToContentSegue"]) {
        BlogViewController *viewController = segue.destinationViewController;
        viewController.blogModel = sender;
    }
}

@end
