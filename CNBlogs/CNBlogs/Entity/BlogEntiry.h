//
//  BlogEntiry.h
//  CNBlogs
//
//  Created by 李远超 on 15/9/2.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AuthorEntity, BlogContentEntity;

@interface BlogEntiry : NSManagedObject

@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSDate * publishDate;
@property (nonatomic, retain) NSDate * updateDate;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * blogapp;
@property (nonatomic, retain) NSNumber * diggs;
@property (nonatomic, retain) NSNumber * views;
@property (nonatomic, retain) NSNumber * comments;
@property (nonatomic, retain) NSDate * likeDate;
@property (nonatomic, retain) AuthorEntity *authorEntity;
@property (nonatomic, retain) BlogContentEntity *contentEntity;

@end
