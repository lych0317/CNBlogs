//
//  NewsDAO.h
//  CNBlogs
//
//  Created by 李远超 on 15/9/2.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "CoreDataDAO.h"

@class NewsModel;

@interface NewsDAO : CoreDataDAO

- (NSInteger)insertNews:(NewsModel *)newsModel;
- (NSInteger)deleteNews:(NewsModel *)newsModel;
- (NewsModel *)findNews:(NewsModel *)newsModel;
- (NSArray *)findAllNews;

@end
