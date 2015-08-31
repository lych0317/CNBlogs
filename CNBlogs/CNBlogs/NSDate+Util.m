//
//  NSDate+Util.m
//  CNBlogs
//
//  Created by 李远超 on 15/8/31.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "NSDate+Util.h"

@implementation NSDate (Util)

- (NSString *)stringWithFormate:(const NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yy-MM-dd HH:mm"];
    return [formatter stringFromDate:self];
}

@end
