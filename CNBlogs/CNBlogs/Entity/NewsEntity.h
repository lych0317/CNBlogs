//
//  NewsEntity.h
//  CNBlogs
//
//  Created by 李远超 on 15/9/2.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NewsContentEntity;

@interface NewsEntity : NSManagedObject

@property (nonatomic, retain) NSString * blogapp;
@property (nonatomic, retain) NSNumber * comments;
@property (nonatomic, retain) NSNumber * diggs;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSDate * publishDate;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * updateDate;
@property (nonatomic, retain) NSNumber * views;
@property (nonatomic, retain) NSString * topic;
@property (nonatomic, retain) NSString * topicIcon;
@property (nonatomic, retain) NSString * sourceName;
@property (nonatomic, retain) NSDate * likeDate;
@property (nonatomic, retain) NewsContentEntity *contentEntity;

@end
