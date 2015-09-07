//
//  UIContentViewController.m
//  CNBlogs
//
//  Created by 李远超 on 15/9/2.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "UIContentViewController.h"
#import "UIContentToolBar.h"

@interface UIContentViewController ()

@end

@implementation UIContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.contentToolBar];
    self.contentToolBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.contentToolBar attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.contentToolBar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.contentToolBar attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.contentToolBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:44]];

    [self.view addSubview:self.contentWebView];
    self.contentWebView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.contentWebView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.contentWebView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.contentWebView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:64]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.contentWebView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentToolBar attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
}

- (void)likeButtonAction:(UIButton *)sender {

}

- (void)shareButtonAction:(UIButton *)sender {

}

- (void)commentButtonAction:(UIButton *)sender {

}

#pragma mark - Getters

- (UIWebView *)contentWebView {
    if (_contentWebView == nil) {
        _contentWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
    }
    return _contentWebView;
}

- (UIContentToolBar *)contentToolBar {
    if (_contentToolBar == nil) {
        _contentToolBar = [[NSBundle mainBundle] loadNibNamed:@"UIContentToolBar" owner:self options:nil].firstObject;
        [_contentToolBar.likeButton addTarget:self action:@selector(likeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_contentToolBar.shareButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_contentToolBar.commentButton addTarget:self action:@selector(commentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _contentToolBar;
}

@end
