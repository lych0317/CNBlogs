//
//  SearchBloggerTableViewController.h
//  CNBlogs
//
//  Created by 李远超 on 15/10/27.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "SearchTableViewController.h"

@class BloggerModel;

typedef void(^SearchDidSelectBloggerBlock)(BloggerModel *model);

@interface SearchBloggerTableViewController : SearchTableViewController

@property (nonatomic, copy) SearchDidSelectBloggerBlock didSelectBloggerBlock;

@end
