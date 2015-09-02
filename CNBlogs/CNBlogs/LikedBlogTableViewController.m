//
//  LikedBlogTableViewController.m
//  CNBlogs
//
//  Created by 李远超 on 15/9/2.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "LikedBlogTableViewController.h"
#import "BlogModel.h"
#import "BlogDAO.h"
#import "BlogTableViewCell.h"

@interface LikedBlogTableViewController ()

@property (nonatomic, strong) NSMutableArray *blogModelArray;

@end

@implementation LikedBlogTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"BlogTableViewCell" bundle:nil] forCellReuseIdentifier:@"BlogTableViewCell"];
}

- (void)reloadData {
    BlogDAO *dao = [[BlogDAO alloc] init];
    self.blogModelArray = [NSMutableArray arrayWithArray:[dao findAllBlog]];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.blogModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BlogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BlogTableViewCell" forIndexPath:indexPath];
    BlogModel *model = self.blogModelArray[indexPath.row];
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
        BlogModel *model = self.blogModelArray[indexPath.row];
        self.didSelectBlogBlock(self, model);
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        BlogModel *model = self.blogModelArray[indexPath.row];
        BlogDAO *dao = [[BlogDAO alloc] init];
        [dao deleteBlog:model];
        [self.blogModelArray removeObject:model];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
