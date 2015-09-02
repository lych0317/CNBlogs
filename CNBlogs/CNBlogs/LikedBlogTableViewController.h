//
//  LikedBlogTableViewController.h
//  CNBlogs
//
//  Created by 李远超 on 15/9/2.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "LikedTableViewController.h"

@class LikedBlogTableViewController, BlogModel;

typedef void(^LikedDidSelectBlogBlock)(LikedBlogTableViewController *viewController, BlogModel *model);

@interface LikedBlogTableViewController : LikedTableViewController

@property (nonatomic, copy) LikedDidSelectBlogBlock didSelectBlogBlock;

@end
