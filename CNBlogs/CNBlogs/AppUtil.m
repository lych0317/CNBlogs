//
//  AppUtil.m
//  CNBlogs
//
//  Created by 李远超 on 15/8/26.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "AppUtil.h"
#import <GRMustache/GRMustache.h>
#import <UMengSocial/UMSocial.h>

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

+ (NSString *)htmlWithDictionary:(NSDictionary *)dictionary usingTemplate:(NSString *)templateName {
    NSString *templatePath = [[NSBundle mainBundle] pathForResource:templateName ofType:@"html" inDirectory:@"html"];
    NSString *template = [NSString stringWithContentsOfFile:templatePath encoding:NSUTF8StringEncoding error:nil];

    return [GRMustacheTemplate renderObject:dictionary fromString:template error:nil];
}

+ (void)showToastWithTitle:(NSString *)title {
    MBProgressHUD *toast = [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication] windows] objectAtIndex:0] animated:YES];
    toast.userInteractionEnabled = NO;
    toast.mode = MBProgressHUDModeCustomView;
    toast.yOffset = -30.0f;
    toast.labelText = title;
    [toast hide:YES afterDelay:2];
}

+ (void)shareText:(NSString *)text inViewController:(UIViewController *)controller {
    [UMSocialSnsService presentSnsIconSheetView:controller appKey:UMengAppKey shareText:text shareImage:nil shareToSnsNames:[UMSocialSnsPlatformManager sharedInstance].allSnsValuesArray delegate:nil];
}

@end
