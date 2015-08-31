//
//  NewsRecommendTableViewController.h
//  CNBlogs
//
//  Created by 李远超 on 15/8/28.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsModel, NewsRecommendTableViewController;

typedef void(^NewsRecommendDidSelectNewsBlock)(NewsRecommendTableViewController *viewController, NewsModel *model);

@interface NewsRecommendTableViewController : UITableViewController

@property (nonatomic, copy) NewsRecommendDidSelectNewsBlock didSelectNewsBlock;

@end
