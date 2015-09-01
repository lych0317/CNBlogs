//
//  AppUtil.h
//  CNBlogs
//
//  Created by 李远超 on 15/8/26.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface AppUtil : NSObject

+ (void)showProgressWithTitle:(NSString *)title addTo:(UIView *)view animated:(BOOL)animated;
+ (void)hideProgressFromView:(UIView *)view animated:(BOOL)animated;
+ (NSString *)htmlWithDictionary:(NSDictionary *)dictionary usingTemplate:(NSString *)templateName;

@end
