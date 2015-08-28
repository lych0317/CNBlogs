//
//  SearchBlogViewController.m
//  CNBlogs
//
//  Created by 李远超 on 15/8/28.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "SearchBlogViewController.h"
#import "ProtocolUtil.h"
#import "BloggerModel.h"
#import "BloggerTableViewCell.h"
#import <MJRefresh/MJRefresh.h>
#import <UIImageView+WebCache.h>

@interface SearchBlogViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *bloggerModelArray;

@end

@implementation SearchBlogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = view;

    [self.tableView registerNib:[UINib nibWithNibName:@"BloggerTableViewCell" bundle:nil] forCellReuseIdentifier:@"BloggerTableViewCell"];

    __weak SearchBlogViewController *weakSelf = self;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestBloggerData];
    }];
}

- (void)requestBloggerData {
    [ProtocolUtil getBloggerListWithSearchText:self.searchBar.text success:^(id data, id identifier) {
        [self.tableView.header endRefreshing];
        self.bloggerModelArray = data;
        [self.tableView reloadData];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [self.tableView.header endRefreshing];
    }];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self.tableView.header beginRefreshing];
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
    cell.updatedLabel.text = [self stringFromDate:model.updated];
    cell.postCountLabel.text = [model.postCount stringValue];
    return cell;
}

- (NSString *)stringFromDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yy-MM-dd HH:mm"];
    return [formatter stringFromDate:date];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
