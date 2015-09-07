//
//  RecommendIn10DTableViewController.h
//  CNBlogs
//
//  Created by 李远超 on 15/8/27.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "UIPageTableViewController.h"

@class BlogModel, RecommendIn10DTableViewController;

typedef void(^RecommendIn10DDidSelectBlogBlock)(RecommendIn10DTableViewController *viewController, BlogModel *model);

@interface RecommendIn10DTableViewController : UIPageTableViewController

@property (nonatomic, copy) RecommendIn10DDidSelectBlogBlock didSelectBlogBlock;

@end
