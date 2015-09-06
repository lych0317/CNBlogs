//
//  BlogViewController.m
//  CNBlogs
//
//  Created by 李远超 on 15/8/26.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "BlogViewController.h"
#import "BlogCommentTableViewController.h"
#import "ContentBarView.h"
#import "ProtocolUtil.h"
#import "BlogContentModel.h"
#import "BlogDAO.h"
#import "BlogModel.h"
#import <MJRefresh/MJRefresh.h>

@interface BlogViewController ()

@end

@implementation BlogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"博客详情", @"");

    __weak BlogViewController *weakSelf = self;
    self.contentWebView.scrollView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestContentData];
    }];

    if (self.blogModel.contentModel) {
        [self loadWebView];
    } else {
        [self.contentWebView.scrollView.header beginRefreshing];
    }

    BlogDAO *dao = [[BlogDAO alloc] init];
    self.contentBarView.likeButton.selected = [dao findBlog:self.blogModel] != nil;
}

- (void)likeButtonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    BlogDAO *dao = [[BlogDAO alloc] init];
    if (sender.selected) {
        [dao insertBlog:self.blogModel];
    } else {
        [dao deleteBlog:self.blogModel];
    }
}

- (void)commentButtonAction:(UIButton *)sender {
    [self performSegueWithIdentifier:@"BlogToCommentSegue" sender:self.blogModel];
}

- (void)loadWebView {
    NSDictionary *dictionary = @{@"title": self.blogModel.title, @"authorName": self.blogModel.authorModel.name, @"publishedTime": [self.blogModel.publishDate stringWithFormate:yyMMddHHmm], @"content": self.blogModel.contentModel.content};

    NSString *html = [AppUtil htmlWithDictionary:dictionary usingTemplate:@"blog"];
    [self.contentWebView loadHTMLString:html baseURL:nil];
}

- (void)requestContentData {
    [ProtocolUtil getBlogContentWithID:self.blogModel.identifier success:^(id data, id identifier) {
        [self.contentWebView.scrollView.header endRefreshing];
        self.blogModel.contentModel = data;
        [self loadWebView];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [self.contentWebView.scrollView.header endRefreshing];
    }];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"BlogToCommentSegue"]) {
        BlogCommentTableViewController *viewController = segue.destinationViewController;
        viewController.blogModel = sender;
    }
}

@end
