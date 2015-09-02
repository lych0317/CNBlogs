//
//  LikedNewsTableViewController.h
//  CNBlogs
//
//  Created by 李远超 on 15/9/2.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "LikedTableViewController.h"

@class LikedNewsTableViewController, NewsModel;

typedef void(^LikedDidSelectNewsBlogck)(LikedNewsTableViewController *viewController, NewsModel *model);

@interface LikedNewsTableViewController : LikedTableViewController

@property (nonatomic, copy) LikedDidSelectNewsBlogck didSelectNewsBlock;

@end
