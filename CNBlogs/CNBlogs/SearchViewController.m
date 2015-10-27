//
//  SearchViewController.m
//  CNBlogs
//
//  Created by 李远超 on 15/10/27.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchBloggerTableViewController.h"
#import "SearchBlogTableViewController.h"
#import "SearchNewsTableViewController.h"

#import "BloggerTableViewController.h"
#import "BlogViewController.h"
#import "NewsViewController.h"

@interface SearchViewController () <UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    SearchBloggerTableViewController *blogger = [[SearchBloggerTableViewController alloc] init];
    blogger.didSelectBloggerBlock = ^(BloggerModel *model) {
        [self performSegueWithIdentifier:@"SearchToBloggerSegue" sender:model];
    };

    SearchBlogTableViewController *blog = [[SearchBlogTableViewController alloc] init];
    blog.didSelectBlogBlock = ^(BlogModel *model) {
        [self performSegueWithIdentifier:@"SearchToBlogSegue" sender:model];
    };

    SearchNewsTableViewController *news = [[SearchNewsTableViewController alloc] init];

    self.viewControllerArray = @[blogger, blog, news];
    self.titleArray = @[NSLocalizedString(@"博主", @""), NSLocalizedString(@"博客", @""), NSLocalizedString(@"新闻", @"")];
    [super viewDidLoad];

    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    self.searchBar.delegate = self;
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.navigationItem.titleView = self.searchBar;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self.viewControllerArray enumerateObjectsUsingBlock:^(SearchTableViewController *searchController, NSUInteger idx, BOOL *stop) {
        [searchController startSearchWithKeyword:searchBar.text];
    }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SearchToBloggerSegue"]) {
        BloggerTableViewController *viewController = segue.destinationViewController;
        viewController.bloggerModel = sender;
    } else if ([segue.identifier isEqualToString:@"SearchToBlogSegue"]) {
        BlogViewController *viewController = segue.destinationViewController;
        viewController.blogModel = sender;
    } else if ([segue.identifier isEqualToString:@"SearchToNewsSegue"]) {
        NewsViewController *viewController = segue.destinationViewController;
        viewController.newsModel = sender;
    }
}

@end
