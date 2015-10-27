//
//  SearchBloggerTableViewController.m
//  CNBlogs
//
//  Created by 李远超 on 15/10/27.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "SearchBloggerTableViewController.h"
#import "ProtocolUtil.h"
#import "BloggerModel.h"
#import "BloggerTableViewCell.h"
#import "BloggerTableViewController.h"
#import <MJRefresh/MJRefresh.h>
#import <UIImageView+WebCache.h>

@interface SearchBloggerTableViewController ()

@property (nonatomic, copy) NSString *keyword;
@property (nonatomic, strong) NSArray *bloggerModelArray;

@end

@implementation SearchBloggerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = view;

    [self.tableView registerNib:[UINib nibWithNibName:@"BloggerTableViewCell" bundle:nil] forCellReuseIdentifier:@"BloggerTableViewCell"];

    __weak SearchBloggerTableViewController *weakSelf = self;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestBloggerData];
    }];
}

- (void)startSearchWithKeyword:(NSString *)keyword {
    self.keyword = keyword;
    [self.tableView.header beginRefreshing];
}

- (void)requestBloggerData {
    [ProtocolUtil getBloggerListWithSearchText:self.keyword success:^(id data, id identifier) {
        [self.tableView.header endRefreshing];
        self.bloggerModelArray = data;
        [self.tableView reloadData];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [self.tableView.header endRefreshing];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bloggerModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BloggerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BloggerTableViewCell" forIndexPath:indexPath];
    BloggerModel *model = self.bloggerModelArray[indexPath.row];
    [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

    }];
    cell.titleLabel.text = model.title;
    cell.updatedLabel.text = [model.updateDate stringWithFormate:yyMMddHHmm];
    cell.postCountLabel.text = [model.postCount stringValue];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BloggerModel *bloggerModel = self.bloggerModelArray[indexPath.row];
    if (self.didSelectBloggerBlock) {
        self.didSelectBloggerBlock(bloggerModel);
    }
}

@end
