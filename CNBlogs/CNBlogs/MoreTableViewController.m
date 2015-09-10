//
//  MoreTableViewController.m
//  CNBlogs
//
//  Created by 李远超 on 15/9/7.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "MoreTableViewController.h"
#import "ShareUtil.h"
#import <iAd/iAd.h>

@interface MoreTableViewController ()

@property (weak, nonatomic) IBOutlet ADBannerView *adBannerView;

@end

@implementation MoreTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - ADBannerViewDelegate

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    self.adBannerView.hidden = NO;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self openUrl:AppUrl];
        } else if (indexPath.row == 1) {
            [ShareUtil shareText:[NSString stringWithFormat:@"博客yuan 你值得拥有 %@", AppUrl] inViewController:self];
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {

        } else if (indexPath.row == 1) {
            [self openUrl:CNBlogsUrl];
        }
    }
}

- (void)openUrl:(NSString *)urlString {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:urlString];
    if ([application canOpenURL:url]) {
        [application openURL:url];
    }
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
