//
//  CommentModel.h
//  CNBlogs
//
//  Created by 李远超 on 15/8/26.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthorModel.h"

@interface CommentModel : NSObject

@property (nonatomic, copy) NSNumber *identifier;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSDate *published;
@property (nonatomic, copy) NSDate *updated;
@property (nonatomic, strong) AuthorModel *author;
@property (nonatomic, copy) NSString *content;

@end
