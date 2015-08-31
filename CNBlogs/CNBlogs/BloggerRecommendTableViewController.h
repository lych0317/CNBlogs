//
//  BloggerRecommendTableViewController.h
//  CNBlogs
//
//  Created by 李远超 on 15/8/27.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BloggerModel, BloggerRecommendTableViewController;

typedef void(^BloggerRecommendDidSelectBloggerBlock)(BloggerRecommendTableViewController *viewController, BloggerModel *model);

@interface BloggerRecommendTableViewController : UITableViewController

@property (nonatomic, copy) BloggerRecommendDidSelectBloggerBlock didSelectBloggerBlock;

@end
