//
//  UIContentViewController.h
//  CNBlogs
//
//  Created by 李远超 on 15/9/2.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "UIBaseViewController.h"

@class ContentBarView;

@interface UIContentViewController : UIBaseViewController

@property (nonatomic, strong) UIWebView *contentWebView;
@property (nonatomic, strong) ContentBarView *contentBarView;

- (void)likeButtonAction:(UIButton *)sender;
- (void)shareButtonAction:(UIButton *)sender;
- (void)commentButtonAction:(UIButton *)sender;

@end
