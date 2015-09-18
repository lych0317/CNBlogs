//
//  BloggerRecommendTableViewController.m
//  CNBlogs
//
//  Created by 李远超 on 15/8/27.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "BloggerRecommendTableViewController.h"
#import "BloggerModel.h"
#import "BloggerTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface BloggerRecommendTableViewController ()

@end

@implementation BloggerRecommendTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"BloggerTableViewCell" bundle:nil] forCellReuseIdentifier:@"BloggerTableViewCell"];

    [self.tableView.header beginRefreshing];
}

- (void)requestDataWithSuccess:(PageTableRequestDataSuccessBlock)success failure:(PageTableRequestDataFailureBlock)failure {
    [ProtocolUtil getBloggerRecommendListWithPageIndex:@(self.pageIndex) pageCount:@(PageCount) success:^(id data, id identifier) {
        success(data);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BloggerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BloggerTableViewCell" forIndexPath:indexPath];
    BloggerModel *model = self.dataArray[indexPath.row];
    [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

    }];
    cell.titleLabel.text = model.title;
    cell.updatedLabel.text = [model.updateDate stringWithFormate:yyMMddHHmm];
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
        BloggerModel *model = self.dataArray[indexPath.row];
        self.didSelectBloggerBlock(self, model);
    }
}

@end
