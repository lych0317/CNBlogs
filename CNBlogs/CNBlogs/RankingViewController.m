//
//  RankingViewController.m
//  CNBlogs
//
//  Created by 李远超 on 15/8/27.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "RankingViewController.h"
#import "BloggerRecommendTableViewController.h"
#import "ViewIn48HTableViewController.h"
#import "RecommendIn10DTableViewController.h"
#import "NewsRecommendTableViewController.h"

#import "BloggerTableViewController.h"
#import "BlogViewController.h"
#import "NewsViewController.h"

@interface RankingViewController ()

@end

@implementation RankingViewController

- (void)viewDidLoad {
    __weak RankingViewController *weakSelf = self;
    BloggerRecommendTableViewController *bloggerViewController = [[BloggerRecommendTableViewController alloc] initWithStyle:UITableViewStylePlain];
    bloggerViewController.didSelectBloggerBlock = ^(BloggerRecommendTableViewController *viewController, BloggerModel *model) {
        [weakSelf performSegueWithIdentifier:@"RankingToBloggerSegue" sender:model];
    };

    ViewIn48HTableViewController *viewIn48HViewController = [[ViewIn48HTableViewController alloc] initWithStyle:UITableViewStylePlain];
    viewIn48HViewController.didSelectBlogBlock = ^(ViewIn48HTableViewController *viewController, BlogModel *model) {
        [weakSelf performSegueWithIdentifier:@"RankingToBlogSegue" sender:model];
    };

    RecommendIn10DTableViewController *recommendIn10DViewController = [[RecommendIn10DTableViewController alloc] initWithStyle:UITableViewStylePlain];
    recommendIn10DViewController.didSelectBlogBlock = ^(RecommendIn10DTableViewController *viewController, BlogModel *model) {
        [weakSelf performSegueWithIdentifier:@"RankingToBlogSegue" sender:model];
    };

    NewsRecommendTableViewController *newsViewController = [[NewsRecommendTableViewController alloc] initWithStyle:UITableViewStylePlain];
    newsViewController.didSelectNewsBlock = ^(NewsRecommendTableViewController *viewController, NewsModel *model) {
        [weakSelf performSegueWithIdentifier:@"RankingToNewsSegue" sender:model];
    };

    self.titleArray = @[NSLocalizedString(@"博主推荐", @""), NSLocalizedString(@"48H阅读", @""), NSLocalizedString(@"10D推荐", @""), NSLocalizedString(@"新闻推荐", @"")];
    self.viewControllerArray = @[bloggerViewController, viewIn48HViewController, recommendIn10DViewController, newsViewController];
    [super viewDidLoad];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"RankingToBloggerSegue"]) {
        BloggerTableViewController *viewController = segue.destinationViewController;
        viewController.bloggerModel = sender;
    } else if ([segue.identifier isEqualToString:@"RankingToBlogSegue"]) {
        BlogViewController *viewController = segue.destinationViewController;
        viewController.blogModel = sender;
    } else if ([segue.identifier isEqualToString:@"RankingToNewsSegue"]) {
        NewsViewController *viewController = segue.destinationViewController;
        viewController.newsModel = sender;
    }
}

@end
