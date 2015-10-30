//
//  NewsViewController.m
//  CNBlogs
//
//  Created by 李远超 on 15/8/31.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsCommentTableViewController.h"
#import "UIContentToolBar.h"
#import "NewsModel.h"
#import "ProtocolUtil.h"
#import "NewsContentModel.h"
#import "NewsDAO.h"
#import "ShareUtil.h"
#import <MJRefresh/MJRefresh.h>

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"新闻详情", "");

    __weak NewsViewController *weakSelf = self;
    self.contentWebView.scrollView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestContentData];
    }];

    if (self.newsModel.contentModel) {
        [self loadWebView];
    } else {
        [self.contentWebView.scrollView.header beginRefreshing];
    }

    NewsDAO *dao = [[NewsDAO alloc] init];
    self.contentToolBar.likeButton.selected = [dao findNews:self.newsModel] != nil;
}

- (void)likeButtonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    NewsDAO *dao = [[NewsDAO alloc] init];
    if (sender.selected) {
        [dao insertNews:self.newsModel];
    } else {
        [dao deleteNews:self.newsModel];
    }
}

- (void)shareButtonAction:(UIButton *)sender {
    [ShareUtil shareText:[NSString stringWithFormat:@"%@\n%@", self.newsModel.title, self.newsModel.link] inViewController:self];
}

- (void)commentButtonAction:(UIButton *)sender {
    [self performSegueWithIdentifier:@"NewsToCommentSegue" sender:self.newsModel];
}

- (void)loadWebView {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    if (self.newsModel.title) {
        [dictionary setObject:self.newsModel.title forKey:@"title"];
    }
    if (self.newsModel.sourceName) {
        [dictionary setObject:self.newsModel.sourceName forKey:@"sourceName"];
    }
    if (self.newsModel.publishDate) {
        [dictionary setObject:[self.newsModel.publishDate stringWithFormate:yyMMddHHmm] forKey:@"submitTime"];
    }
    if (self.newsModel.contentModel.content) {
        [dictionary setObject:self.newsModel.contentModel.content forKey:@"content"];
    }

    NSString *html = [AppUtil htmlWithDictionary:dictionary usingTemplate:@"news"];
    [self.contentWebView loadHTMLString:html baseURL:nil];
}

- (void)requestContentData {
    [ProtocolUtil getNewsContentWithID:self.newsModel.identifier success:^(id data, id identifier) {
        [self.contentWebView.scrollView.header endRefreshing];
        self.newsModel.contentModel = data;
        [self loadWebView];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [self.contentWebView.scrollView.header endRefreshing];
    }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"NewsToCommentSegue"]) {
        NewsCommentTableViewController *viewController = segue.destinationViewController;
        viewController.newsModel = sender;
    }
}

@end
