//
//  BlogModel.h
//  CNBlogs
//
//  Created by 李远超 on 15/8/26.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthorModel.h"
#import "BlogContentModel.h"

@interface BlogModel : NSObject

@property (nonatomic, copy) NSNumber *identifier;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSDate *publishDate;
@property (nonatomic, copy) NSDate *updateDate;
@property (nonatomic, strong) AuthorModel *authorModel;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *blogapp;
@property (nonatomic, copy) NSNumber *diggs;
@property (nonatomic, copy) NSNumber *views;
@property (nonatomic, copy) NSNumber *comments;

// 非协议字段
@property (nonatomic, strong) BlogContentModel *contentModel;

@end
