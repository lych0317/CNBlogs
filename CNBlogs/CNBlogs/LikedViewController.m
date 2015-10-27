//
//  LikedViewController.m
//  CNBlogs
//
//  Created by 李远超 on 15/8/31.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "LikedViewController.h"
#import "LikedBloggerTableViewController.h"
#import "LikedBlogTableViewController.h"
#import "LikedNewsTableViewController.h"

#import "BloggerTableViewController.h"
#import "BlogViewController.h"
#import "NewsViewController.h"

@interface LikedViewController ()

@end

@implementation LikedViewController

- (void)viewDidLoad {
    self.titleArray = @[NSLocalizedString(@"博主", @""), NSLocalizedString(@"博客", @""), NSLocalizedString(@"新闻", @"")];

    __weak LikedViewController *weakSelf = self;
    LikedBloggerTableViewController *bloggerViewController = [[LikedBloggerTableViewController alloc] initWithStyle:UITableViewStylePlain];
    bloggerViewController.didSelectBloggerBlock = ^(LikedBloggerTableViewController *viewController, BloggerModel *model) {
        [weakSelf performSegueWithIdentifier:@"LikedToBloggerSegue" sender:model];
    };

    LikedBlogTableViewController *blogViewController = [[LikedBlogTableViewController alloc] initWithStyle:UITableViewStylePlain];
    blogViewController.didSelectBlogBlock = ^(LikedBlogTableViewController *viewController, BlogModel *model) {
        [weakSelf performSegueWithIdentifier:@"LikedToBlogSegue" sender:model];
    };

    LikedNewsTableViewController *newsViewController = [[LikedNewsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    newsViewController.didSelectNewsBlock = ^(LikedNewsTableViewController *viewController, NewsModel *model) {
        [weakSelf performSegueWithIdentifier:@"LikedToNewsSegue" sender:model];
    };

    self.viewControllerArray = @[bloggerViewController, blogViewController, newsViewController];
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    LikedTableViewController *viewController = self.viewControllerArray[self.segmentedControl.selectedSegmentIndex];
    [viewController reloadData];
}

- (IBAction)editAction:(UIBarButtonItem *)sender {
    LikedTableViewController *viewController = self.viewControllerArray[self.segmentedControl.selectedSegmentIndex];
    viewController.tableView.editing = !viewController.tableView.editing;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"LikedToBloggerSegue"]) {
        BloggerTableViewController *viewController = segue.destinationViewController;
        viewController.bloggerModel = sender;
    } else if ([segue.identifier isEqualToString:@"LikedToBlogSegue"]) {
        BlogViewController *viewController = segue.destinationViewController;
        viewController.blogModel = sender;
    } else if ([segue.identifier isEqualToString:@"LikedToNewsSegue"]) {
        NewsViewController *viewController = segue.destinationViewController;
        viewController.newsModel = sender;
    }
}

@end
