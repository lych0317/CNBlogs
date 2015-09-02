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
#import "BloggerDAO.h"
#import <MJRefresh/MJRefresh.h>

@interface BloggerTableViewController ()

@property (nonatomic, strong) NSMutableArray *blogModelArray;
@property (nonatomic, assign) NSInteger pageIndex;

@end

@implementation BloggerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.bloggerModel.title;

    UIButton *likeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [likeButton setImage:[UIImage imageNamed:@"toolbar-star"] forState:UIControlStateNormal];
    [likeButton setImage:[UIImage imageNamed:@"toolbar-starred"] forState:UIControlStateSelected];
    [likeButton addTarget:self action:@selector(likeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    BloggerDAO *dao = [[BloggerDAO alloc] init];
    likeButton.selected = [dao findBlogger:self.bloggerModel] != nil;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:likeButton];
    self.navigationItem.rightBarButtonItem = item;

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

- (void)likeButtonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    BloggerDAO *dao = [[BloggerDAO alloc] init];
    if (sender.selected) {
        [dao insertBlogger:self.bloggerModel];
    } else {
        [dao deleteBlogger:self.bloggerModel];
    }
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
    cell.authorLabel.text = model.authorModel.name;
    cell.publishedLabel.text = [model.publishDate stringWithFormate:yyMMddHHmm];
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
