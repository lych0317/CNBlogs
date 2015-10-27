//
//  SearchNewsTableViewController.m
//  CNBlogs
//
//  Created by 李远超 on 15/10/27.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "SearchNewsTableViewController.h"
#import "SearchNewsProtocol.h"
#import "NewsModel.h"
#import "NewsContentModel.h"
#import "NewsTableViewCell.h"

@interface SearchNewsTableViewController ()

@property (nonatomic, copy) NSString *keyword;

@end

@implementation SearchNewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsTableViewCell"];
}

- (void)startSearchWithKeyword:(NSString *)keyword {
    self.keyword = keyword;
    [self.tableView.header beginRefreshing];
}

- (void)requestDataWithSuccess:(PageTableRequestDataSuccessBlock)success failure:(PageTableRequestDataFailureBlock)failure {
    [[[SearchNewsProtocol alloc] init] getNewsWithKeyword:self.keyword page:self.pageIndex success:^(id data, id identifier) {
        success(data);
        self.tableView.footer.hidden = NO;
    } failure:^(NSError *error) {
        failure(error);
    }];
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

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.didSelectNewsBlock) {
        NewsModel *model = self.dataArray[indexPath.row];
        self.didSelectNewsBlock(model);
    }
}

@end
