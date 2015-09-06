//
//  BlogCommentTableViewController.h
//  CNBlogs
//
//  Created by 李远超 on 15/9/2.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BlogModel;

@interface BlogCommentTableViewController : UITableViewController

@property (nonatomic, strong) BlogModel *blogModel;

@end
