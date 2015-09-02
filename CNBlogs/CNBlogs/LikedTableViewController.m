//
//  LikedTableViewController.m
//  CNBlogs
//
//  Created by 李远超 on 15/9/2.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "LikedTableViewController.h"

@interface LikedTableViewController ()

@end

@implementation LikedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;

    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = view;

    [self reloadData];
}

- (void)reloadData {
}

#pragma mark - Table view data source

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return NSLocalizedString(@"删除", @"");
}

@end
