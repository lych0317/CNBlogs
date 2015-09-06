//
//  BlogCommentTableViewController.m
//  CNBlogs
//
//  Created by 李远超 on 15/9/2.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "BlogCommentTableViewController.h"
#import "CommentTableViewCell.h"
#import "BlogModel.h"
#import "AuthorModel.h"
#import "CommentModel.h"
#import "ProtocolUtil.h"
#import <MJRefresh/MJRefresh.h>

@interface BlogCommentTableViewController ()

@property (nonatomic, strong) NSMutableArray *commentModelArray;
@property (nonatomic, assign) NSInteger pageIndex;

@property (nonatomic, strong) CommentTableViewCell *prototypeCell;

@end

@implementation BlogCommentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;

    [self.tableView registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"CommentTableViewCell"];

    self.prototypeCell = [[NSBundle mainBundle] loadNibNamed:@"CommentTableViewCell" owner:self options:nil].firstObject;

    __weak BlogCommentTableViewController *weakSelf = self;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestCommentDataForHeader];
    }];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestCommentDataForFooter];
    }];

    [self.tableView.header beginRefreshing];
}

- (void)requestCommentDataForHeader {
    self.pageIndex = 1;
    self.commentModelArray = [NSMutableArray array];
    [self.tableView reloadData];
    [self requestCommentData];
}

- (void)requestCommentDataForFooter {
    [self requestCommentData];
}

- (void)requestCommentData {
    [ProtocolUtil getBlogCommentListWithID:self.blogModel.identifier pageIndex:@(self.pageIndex) pageCount:@(PageCount) success:^(id data, id identifier) {
        self.pageIndex++;
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        NSArray *array = data;
        [self.commentModelArray addObjectsFromArray:array];
        self.tableView.footer.hidden = array.count < PageCount;
        [self.tableView reloadData];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentTableViewCell" forIndexPath:indexPath];
    CommentModel *model = self.commentModelArray[indexPath.row];
    cell.authorLabel.text = model.authorModel.name;
    cell.publishDateLabel.text = [model.publishDate stringWithFormate:yyMMddHHmm];
    cell.contentLabel.text = [model.content deleteHTMLTag];
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentModel *model = self.commentModelArray[indexPath.row];
    self.prototypeCell.authorLabel.text = model.authorModel.name;
    self.prototypeCell.publishDateLabel.text = [model.publishDate stringWithFormate:yyMMddHHmm];
    self.prototypeCell.contentLabel.text = [model.content deleteHTMLTag];
    CGSize size = [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return 1 + size.height;
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
