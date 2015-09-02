//
//  BloggerDAO.h
//  CNBlogs
//
//  Created by 李远超 on 15/9/1.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "CoreDataDAO.h"
#import "BloggerModel.h"

@interface BloggerDAO : CoreDataDAO

- (NSInteger)insertBlogger:(BloggerModel *)bloggerModel;
- (NSInteger)deleteBlogger:(BloggerModel *)bloggerModel;
- (NSArray *)findAllBlogger;

@end
