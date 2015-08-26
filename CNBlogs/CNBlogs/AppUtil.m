//
//  AppUtil.m
//  CNBlogs
//
//  Created by 李远超 on 15/8/26.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "AppUtil.h"

@implementation AppUtil

+ (void)showProgressWithTitle:(NSString *)title addTo:(UIView *)view animated:(BOOL)animated {
    if (view == nil) {
        view = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    }
    MBProgressHUD *loading = [MBProgressHUD showHUDAddedTo:view animated:animated];
    loading.labelText = title;
}

+ (void)hideProgressFromView:(UIView *)view animated:(BOOL)animated {
    if (view == nil) {
        view = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    }
    [MBProgressHUD hideAllHUDsForView:view animated:animated];
}

@end
