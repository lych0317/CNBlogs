//
//  NewsModel.h
//  CNBlogs
//
//  Created by 李远超 on 15/8/26.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsContentModel.h"

@interface NewsModel : NSObject

@property (nonatomic, copy) NSNumber *identifier;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSDate *publishDate;
@property (nonatomic, copy) NSDate *updateDate;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSNumber *diggs;
@property (nonatomic, copy) NSNumber *views;
@property (nonatomic, copy) NSNumber *comments;
@property (nonatomic, copy) NSString *topic;
@property (nonatomic, copy) NSString *topicIcon;
@property (nonatomic, copy) NSString *sourceName;

// 非协议字段
@property (nonatomic, strong) NewsContentModel *contentModel;

@end
