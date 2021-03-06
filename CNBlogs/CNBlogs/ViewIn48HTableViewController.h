//
//  ViewIn48HTableViewController.h
//  CNBlogs
//
//  Created by 李远超 on 15/8/27.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "UIPageTableViewController.h"

@class BlogModel, ViewIn48HTableViewController;

typedef void(^ViewIn48HDidSelectBlogBlock)(ViewIn48HTableViewController *viewController, BlogModel *model);

@interface ViewIn48HTableViewController : UIPageTableViewController

@property (nonatomic, copy) ViewIn48HDidSelectBlogBlock didSelectBlogBlock;

@end
