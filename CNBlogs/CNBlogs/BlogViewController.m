//
//  BlogViewController.m
//  CNBlogs
//
//  Created by 李远超 on 15/8/26.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "BlogViewController.h"
#import "ProtocolUtil.h"
#import "BlogContentModel.h"
#import <MJRefresh/MJRefresh.h>

@interface BlogViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *contentWebView;

@end

@implementation BlogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.blogModel.title;

    __weak BlogViewController *weakSelf = self;
    self.contentWebView.scrollView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestContentData];
    }];

    [self.contentWebView.scrollView.header beginRefreshing];
}

- (void)requestContentData {
    [ProtocolUtil getBlogContentWithID:self.blogModel.identifier success:^(id data, id identifier) {
        [self.contentWebView.scrollView.header endRefreshing];
        BlogContentModel *model = data;
        model.blogModel = self.blogModel;
        [self.contentWebView loadHTMLString:model.html baseURL:nil];
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
