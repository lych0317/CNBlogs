//
//  BaseResult.h
//  CNBlogs
//
//  Created by 李远超 on 15/10/26.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseResult : NSObject

@property (nonatomic, copy) NSNumber *status;
@property (nonatomic, strong) id data;

@end
