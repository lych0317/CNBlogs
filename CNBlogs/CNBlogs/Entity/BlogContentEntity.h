//
//  BlogContentEntity.h
//  CNBlogs
//
//  Created by 李远超 on 15/9/2.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BlogContentEntity : NSManagedObject

@property (nonatomic, retain) NSString * content;

@end
