//
//  NewsViewController.m
//  CNBlogs
//
//  Created by 李远超 on 15/8/31.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsCommentTableViewController.h"
#import "ContentBarView.h"
#import "NewsModel.h"
#import "ProtocolUtil.h"
#import "NewsContentModel.h"
#import "NewsDAO.h"
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
    self.contentBarView.likeButton.selected = [dao findNews:self.newsModel] != nil;
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

- (void)commentButtonAction:(UIButton *)sender {
    [self performSegueWithIdentifier:@"NewsToCommentSegue" sender:self.newsModel];
}

- (void)loadWebView {
    NSDictionary *dictionary = @{@"title": self.newsModel.title, @"sourceName": self.newsModel.sourceName, @"submitTime": [self.newsModel.publishDate stringWithFormate:yyMMddHHmm], @"content": self.newsModel.contentModel.content};

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
