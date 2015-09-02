//
//  LikedBloggerTableViewController.h
//  CNBlogs
//
//  Created by 李远超 on 15/9/1.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "LikedTableViewController.h"

@class LikedBloggerTableViewController, BloggerModel;

typedef void(^LikedDidSelectBloggerBlock)(LikedBloggerTableViewController *viewController, BloggerModel *model);

@interface LikedBloggerTableViewController : LikedTableViewController

@property (nonatomic, copy) LikedDidSelectBloggerBlock didSelectBloggerBlock;

@end
