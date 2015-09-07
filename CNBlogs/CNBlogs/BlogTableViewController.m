//
//  BlogTableViewController.m
//  CNBlogs
//
//  Created by 李远超 on 15/8/26.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "BlogTableViewController.h"
#import "ProtocolUtil.h"
#import "BlogModel.h"
#import "BlogTableViewCell.h"
#import "BlogViewController.h"
#import <MJRefresh/MJRefresh.h>

@interface BlogTableViewController ()

@end

@implementation BlogTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"BlogTableViewCell" bundle:nil] forCellReuseIdentifier:@"BlogTableViewCell"];

    [self.tableView.header beginRefreshing];
}

- (void)requestData {
    [ProtocolUtil getBlogListWithPageIndex:@(self.pageIndex) pageCount:@(PageCount) success:self.successBlock failure:self.failureBlock];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BlogModel *model = self.dataArray[indexPath.row];
    [self performSegueWithIdentifier:@"BlogListToContentSegue" sender:model];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"BlogListToContentSegue"]) {
        BlogViewController *viewController = segue.destinationViewController;
        viewController.blogModel = sender;
    }
}

@end
