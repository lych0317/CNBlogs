//
//  BlogDAO.h
//  CNBlogs
//
//  Created by 李远超 on 15/9/2.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "CoreDataDAO.h"
#import "BlogModel.h"

@interface BlogDAO : CoreDataDAO

- (NSInteger)insertBlog:(BlogModel *)blogModel;
- (NSInteger)deleteBlog:(BlogModel *)blogModel;
- (BlogModel *)findBlog:(BlogModel *)blogModel;
- (NSArray *)findAllBlog;

@end
