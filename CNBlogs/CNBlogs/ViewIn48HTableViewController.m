//
//  ViewIn48HTableViewController.m
//  CNBlogs
//
//  Created by 李远超 on 15/8/27.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "ViewIn48HTableViewController.h"
#import "BlogModel.h"
#import "BlogTableViewCell.h"
#import "BlogViewController.h"

@interface ViewIn48HTableViewController ()

@end

@implementation ViewIn48HTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"BlogTableViewCell" bundle:nil] forCellReuseIdentifier:@"BlogTableViewCell"];

    self.tableView.footer = nil;

    [self.tableView.header beginRefreshing];
}

- (void)requestDataWithSuccess:(PageTableRequestDataSuccessBlock)success failure:(PageTableRequestDataFailureBlock)failure {
    [ProtocolUtil getViewIn48HListWithCount:@(20) success:^(id data, id identifier) {
        success(data);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BlogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BlogTableViewCell" forIndexPath:indexPath];
    BlogModel *model = self.dataArray[indexPath.row];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.didSelectBlogBlock) {
        BlogModel *model = self.dataArray[indexPath.row];
        self.didSelectBlogBlock(self, model);
    }
}

@end
