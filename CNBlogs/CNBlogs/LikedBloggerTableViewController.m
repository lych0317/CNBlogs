//
//  LikedBloggerTableViewController.m
//  CNBlogs
//
//  Created by 李远超 on 15/9/1.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "LikedBloggerTableViewController.h"
#import "BloggerDAO.h"
#import "BloggerTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface LikedBloggerTableViewController ()

@property (nonatomic, strong) NSMutableArray *bloggerModelArray;

@end

@implementation LikedBloggerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"BloggerTableViewCell" bundle:nil] forCellReuseIdentifier:@"BloggerTableViewCell"];
}

- (void)reloadData {
    BloggerDAO *dao = [[BloggerDAO alloc] init];
    self.bloggerModelArray = [NSMutableArray arrayWithArray:[dao findAllBlogger]];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bloggerModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BloggerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BloggerTableViewCell" forIndexPath:indexPath];
    BloggerModel *model = self.bloggerModelArray[indexPath.row];
    [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

    }];
    cell.titleLabel.text = model.title;
    cell.updatedLabel.text = [model.updateDate stringWithFormate:yyMMddHHmm];
    cell.postCountLabel.text = [model.postCount stringValue];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        BloggerModel *model = self.bloggerModelArray[indexPath.row];
        BloggerDAO *dao = [[BloggerDAO alloc] init];
        [dao deleteBlogger:model];
        [self.bloggerModelArray removeObject:model];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.didSelectBloggerBlock) {
        BloggerModel *bloggerModel = self.bloggerModelArray[indexPath.row];
        self.didSelectBloggerBlock(self, bloggerModel);
    }
}

@end
