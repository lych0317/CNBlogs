//
//  BlogContentModel.m
//  CNBlogs
//
//  Created by 李远超 on 15/8/26.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "BlogContentModel.h"
#import "BlogModel.h"

@implementation BlogContentModel

- (NSString *)html {
    if (_html == nil) {
        NSDictionary *dictionary = @{@"title": self.blogModel.title, @"authorName": self.blogModel.author.name, @"publishedTime": [self.blogModel.publishDate stringWithFormate:yyMMddHHmm], @"content": self.content};

        _html = [AppUtil htmlWithDictionary:dictionary usingTemplate:@"blog"];
    }
    return _html;
}

@end
