//
//  NewsCommentTableViewController.h
//  CNBlogs
//
//  Created by 李远超 on 15/9/2.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsModel;

@interface NewsCommentTableViewController : UITableViewController

@property (nonatomic, strong) NewsModel *newsModel;

@end
