//
//  SearchNewsTableViewController.h
//  CNBlogs
//
//  Created by 李远超 on 15/10/27.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "SearchTableViewController.h"

@class NewsModel;

typedef void(^SearchDidSelectNewsBlock)(NewsModel *model);

@interface SearchNewsTableViewController : SearchTableViewController

@property (nonatomic, copy) SearchDidSelectNewsBlock didSelectNewsBlock;

@end
