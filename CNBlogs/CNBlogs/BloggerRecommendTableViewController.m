//
//  BloggerRecommendTableViewController.m
//  CNBlogs
//
//  Created by 李远超 on 15/8/27.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "BloggerRecommendTableViewController.h"
#import "ProtocolUtil.h"
#import "BloggerModel.h"
#import "BloggerTableViewCell.h"
#import <MJRefresh/MJRefresh.h>
#import <UIImageView+WebCache.h>

@interface BloggerRecommendTableViewController ()

@property (nonatomic, strong) NSMutableArray *bloggerModelArray;
@property (nonatomic, assign) NSInteger pageIndex;

@end

@implementation BloggerRecommendTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;

    [self.tableView registerNib:[UINib nibWithNibName:@"BloggerTableViewCell" bundle:nil] forCellReuseIdentifier:@"BloggerTableViewCell"];

    __weak BloggerRecommendTableViewController *weakSelf = self;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestBloggerDataForHeader];
    }];

    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestBloggerDataForFooter];
    }];

    [self.tableView.header beginRefreshing];
}

- (void)requestBloggerDataForHeader {
    self.pageIndex = 1;
    self.bloggerModelArray = [NSMutableArray array];
    [self.tableView reloadData];
    [self requestBloggerData];
}

- (void)requestBloggerDataForFooter {
    [self requestBloggerData];
}

- (void)requestBloggerData {
    [ProtocolUtil getBloggerRecommendListWithPageIndex:@(self.pageIndex) pageCount:@(PageCount) success:^(id data, id identifier) {
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        self.pageIndex++;
        NSArray *array = data;
        [self.bloggerModelArray addObjectsFromArray:array];
        self.tableView.footer.hidden = array.count < PageCount;
        [self.tableView reloadData];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bloggerModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BloggerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BloggerTableViewCell" forIndexPath:indexPath];
    BloggerModel *model = self.bloggerModelArray[indexPath.row];
    [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

    }];
    cell.titleLabel.text = model.title;
    cell.updatedLabel.text = [model.updated stringWithFormate:yyMMddHHmm];
    cell.postCountLabel.text = [model.postCount stringValue];
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.didSelectBloggerBlock) {
        BloggerModel *model = self.bloggerModelArray[indexPath.row];
        self.didSelectBloggerBlock(self, model);
    }
}

@end
