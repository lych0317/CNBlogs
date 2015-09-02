//
//  BloggerModel.h
//  CNBlogs
//
//  Created by 李远超 on 15/8/26.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BloggerModel : NSObject

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSDate *updateDate;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *blogapp;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSNumber *postCount;

@end
