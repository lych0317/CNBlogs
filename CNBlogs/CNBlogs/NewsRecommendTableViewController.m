//
//  NewsRecommendTableViewController.m
//  CNBlogs
//
//  Created by 李远超 on 15/8/28.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "NewsRecommendTableViewController.h"
#import "NewsModel.h"
#import "NewsTableViewCell.h"

@interface NewsRecommendTableViewController ()

@end

@implementation NewsRecommendTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsTableViewCell"];

    [self.tableView.header beginRefreshing];
}

- (void)requestData {
    [ProtocolUtil getNewsRecommendListWithPageIndex:@(self.pageIndex) pageCount:@(PageCount) success:self.successBlock failure:self.failureBlock];
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsTableViewCell" forIndexPath:indexPath];
    NewsModel *model = self.dataArray[indexPath.row];
    cell.titleLabel.text = model.title;
    cell.summaryLabel.text = model.summary;
    cell.sourceLabel.text = model.sourceName;
    cell.publishedLabel.text = [model.publishDate stringWithFormate:yyMMddHHmm];
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
        NewsModel *model = self.dataArray[indexPath.row];
        self.didSelectNewsBlock(self, model);
    }
}

@end
