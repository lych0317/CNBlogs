//
//  BloggerTableViewController.h
//  CNBlogs
//
//  Created by 李远超 on 15/8/28.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "UIPageTableViewController.h"

@class BloggerModel;

@interface BloggerTableViewController : UIPageTableViewController

@property (nonatomic, strong) BloggerModel *bloggerModel;

@end
