//
//  ContentBarView.m
//  CNBlogs
//
//  Created by 李远超 on 15/9/2.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "ContentBarView.h"

@implementation ContentBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIBarButtonItem *leftSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

        UIBarButtonItem *likeItem = [[UIBarButtonItem alloc] initWithCustomView:self.likeButton];
        UIBarButtonItem *likeSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

        UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithCustomView:self.shareButton];
        UIBarButtonItem *shareSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

        UIBarButtonItem *commentItem = [[UIBarButtonItem alloc] initWithCustomView:self.commentButton];

        UIBarButtonItem *rightSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

        self.items = @[leftSpace, likeItem, likeSpace, shareItem, shareSpace, commentItem, rightSpace];
    }
    return self;
}

#pragma mark - Getters

- (UIButton *)likeButton {
    if (_likeButton == nil) {
        _likeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [_likeButton setImage:[UIImage imageNamed:@"toolbar-star"] forState:UIControlStateNormal];
        [_likeButton setImage:[UIImage imageNamed:@"toolbar-starred"] forState:UIControlStateSelected];
    }
    return _likeButton;
}

- (UIButton *)shareButton {
    if (_shareButton == nil) {
        _shareButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [_shareButton setImage:[UIImage imageNamed:@"toolbar-starred"] forState:UIControlStateNormal];
    }
    return _shareButton;
}

- (UIButton *)commentButton {
    if (_commentButton == nil) {
        _commentButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [_commentButton setImage:[UIImage imageNamed:@"toolbar-starred"] forState:UIControlStateNormal];
    }
    return _commentButton;
}

@end
