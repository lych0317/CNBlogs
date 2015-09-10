//
//  ShareUtil.m
//  CNBlogs
//
//  Created by 李远超 on 15/9/10.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "ShareUtil.h"
#import <UMengSocial/UMSocial.h>

@implementation ShareUtil

+ (void)shareText:(NSString *)text inViewController:(UIViewController *)controller {
    NSArray *array = @[UMShareToSina, UMShareToTencent, UMShareToQzone, UMShareToQQ, UMShareToWechatSession, UMShareToWechatTimeline, UMShareToWechatFavorite, UMShareToFacebook, UMShareToEmail, UMShareToSms];
    [UMSocialSnsService presentSnsIconSheetView:controller appKey:UMengAppKey shareText:text shareImage:nil shareToSnsNames:array delegate:nil];
}

@end
