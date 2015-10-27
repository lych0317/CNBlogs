//
//  SearchBlogTableViewController.m
//  CNBlogs
//
//  Created by 李远超 on 15/10/27.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "SearchBlogTableViewController.h"
#import "SearchBlogProtocol.h"
#import "BlogModel.h"
#import "BlogTableViewCell.h"
#import "BlogViewController.h"
#import <MJRefresh/MJRefresh.h>

@interface SearchBlogTableViewController ()

@property (nonatomic, copy) NSString *keyword;

@end

@implementation SearchBlogTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"BlogTableViewCell" bundle:nil] forCellReuseIdentifier:@"BlogTableViewCell"];
}

- (void)startSearchWithKeyword:(NSString *)keyword {
    self.keyword = keyword;
    [self.tableView.header beginRefreshing];
}

- (void)requestDataWithSuccess:(PageTableRequestDataSuccessBlock)success failure:(PageTableRequestDataFailureBlock)failure {
    [[[SearchBlogProtocol alloc] init] getBlogWithKeyword:self.keyword page:self.pageIndex success:^(id data, id identifier) {
        success(data);
        self.tableView.footer.hidden = NO;
    } failure:^(NSError *error) {
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
    BlogModel *model = self.dataArray[indexPath.row];
    if (self.didSelectBlogBlock) {
        self.didSelectBlogBlock(model);
    }
}

@end
