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

@interface BlogCommentTableViewController ()

@property (nonatomic, strong) CommentTableViewCell *prototypeCell;

@end

@implementation BlogCommentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"CommentTableViewCell"];

    self.prototypeCell = [[NSBundle mainBundle] loadNibNamed:@"CommentTableViewCell" owner:self options:nil].firstObject;

    [self.tableView.header beginRefreshing];
}

- (void)requestDataWithSuccess:(PageTableRequestDataSuccessBlock)success failure:(PageTableRequestDataFailureBlock)failure {
    [ProtocolUtil getBlogCommentListWithID:self.blogModel.identifier pageIndex:@(self.pageIndex) pageCount:@(PageCount) success:^(id data, id identifier) {
        success(data);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentTableViewCell" forIndexPath:indexPath];
    CommentModel *model = self.dataArray[indexPath.row];
    [cell setupCellWithCommentModel:model];
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentModel *model = self.dataArray[indexPath.row];
    return [self.prototypeCell cellHeightForCommentModel:model tableWidth:CGRectGetWidth(tableView.frame)];
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
