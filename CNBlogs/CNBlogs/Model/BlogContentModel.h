//
//  BlogContentModel.h
//  CNBlogs
//
//  Created by 李远超 on 15/8/26.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BlogModel;

@interface BlogContentModel : NSObject

@property (nonatomic, copy) NSString *content;

// 非协议字段
@property (nonatomic, strong) BlogModel *blogModel;
@property (nonatomic, copy) NSString *html;

@end
