//
//  BloggerEntity.h
//  CNBlogs
//
//  Created by 李远超 on 15/9/1.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BloggerEntity : NSManagedObject

@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * updateDate;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * blogapp;
@property (nonatomic, retain) NSString * avatar;
@property (nonatomic, retain) NSNumber * postCount;
@property (nonatomic, retain) NSDate * likeDate;

@end
