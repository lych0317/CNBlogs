//
//  NewsViewController.h
//  CNBlogs
//
//  Created by 李远超 on 15/8/31.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "UIContentViewController.h"

@class NewsModel;

@interface NewsViewController : UIContentViewController

@property (nonatomic, strong) NewsModel *newsModel;

@end
