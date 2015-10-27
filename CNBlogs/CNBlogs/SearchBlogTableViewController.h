//
//  SearchBlogTableViewController.h
//  CNBlogs
//
//  Created by 李远超 on 15/10/27.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "SearchTableViewController.h"

@class BlogModel;

typedef void(^SearchDidSelectBlogBlock)(BlogModel *model);

@interface SearchBlogTableViewController : SearchTableViewController

@property (nonatomic, copy) SearchDidSelectBlogBlock didSelectBlogBlock;

@end
