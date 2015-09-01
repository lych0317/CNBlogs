//
//  NewsContentModel.m
//  CNBlogs
//
//  Created by 李远超 on 15/8/26.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "NewsContentModel.h"

@implementation NewsContentModel

- (NSString *)html {
    if (_html == nil) {
        NSDictionary *dictionary = @{@"title": self.title, @"sourceName": self.sourceName, @"submitTime": [self.submitDate stringWithFormate:yyMMddHHmm], @"content": self.content};

        _html = [AppUtil htmlWithDictionary:dictionary usingTemplate:@"news"];
    }
    return _html;
}

@end
