//
//  NSDate+Util.h
//  CNBlogs
//
//  Created by 李远超 on 15/8/31.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import <Foundation/Foundation.h>

const static NSString *yyMMddHHmm = @"yy-MM-dd HH:mm";

@interface NSDate (Util)

- (NSString *)stringWithFormate:(const NSString *)format;

@end
