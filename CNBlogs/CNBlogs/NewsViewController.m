//
//  NewsViewController.m
//  CNBlogs
//
//  Created by 李远超 on 15/8/31.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsModel.h"
#import "ProtocolUtil.h"
#import "NewsContentModel.h"
#import <MJRefresh/MJRefresh.h>

@interface NewsViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *contentWebView;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.newsModel.title;

    __weak NewsViewController *weakSelf = self;
    self.contentWebView.scrollView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestContentData];
    }];

    [self.contentWebView.scrollView.header beginRefreshing];
}

- (void)requestContentData {
    [ProtocolUtil getNewsContentWithID:self.newsModel.identifier success:^(NewsContentModel *data, id identifier) {
        [self.contentWebView.scrollView.header endRefreshing];
        [self.contentWebView loadHTMLString:data.html baseURL:nil];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [self.contentWebView.scrollView.header endRefreshing];
    }];
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
