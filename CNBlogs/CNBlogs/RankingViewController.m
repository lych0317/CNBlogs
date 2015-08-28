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

@interface RankingViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) BloggerRecommendTableViewController *bloggerViewController;
@property (nonatomic, strong) ViewIn48HTableViewController *viewIn48HViewController;
@property (nonatomic, strong) RecommendIn10DTableViewController *recommendIn10DViewController;
@property (nonatomic, strong) NewsRecommendTableViewController *newsViewController;

@end

@implementation RankingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bloggerViewController = [[BloggerRecommendTableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.viewIn48HViewController = [[ViewIn48HTableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.recommendIn10DViewController = [[RecommendIn10DTableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.newsViewController = [[NewsRecommendTableViewController alloc] initWithStyle:UITableViewStylePlain];
}

- (IBAction)segmentedControlValueChanged:(UISegmentedControl *)sender {
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:sender.selectedSegmentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    UIViewController *viewController = nil;
    if (indexPath.row == 0) {
        viewController = self.bloggerViewController;
    } else if (indexPath.row == 1) {
        viewController = self.viewIn48HViewController;
    } else if (indexPath.row == 2) {
        viewController = self.recommendIn10DViewController;
    } else if (indexPath.row == 3) {
        viewController = self.newsViewController;
    }
    viewController.view.frame = CGRectMake(0, 0, CGRectGetWidth(collectionView.frame), CGRectGetHeight(collectionView.frame));
    [cell.contentView addSubview:viewController.view];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.bounds.size;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int index = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    [self.segmentedControl setSelectedSegmentIndex:index];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

@end
