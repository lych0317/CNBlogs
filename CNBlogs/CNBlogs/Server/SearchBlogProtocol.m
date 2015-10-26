//
//  SearchBlogProtocol.m
//  CNBlogs
//
//  Created by 李远超 on 15/10/26.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "SearchBlogProtocol.h"
#import "BlogModel.h"
#import "AuthorModel.h"

@implementation SearchBlogProtocol

- (void)getBlogWithKeyword:(NSString *)keyword page:(NSInteger)page success:(ProtocolSuccessBlock)success failure:(ProtocolFailureBlock)failure {
    RKObjectMapping *responseMapping = [self baseResultMapping];
    [responseMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"data" toKeyPath:@"data" withMapping:[self blogModelMapping]]];

    [self getObjectsAtPath:@"search/blog" parameterDictionary:@{@"keyword": keyword, @"page": @(page)} identifier:nil objectMapping:responseMapping success:success failure:failure];
}

- (RKObjectMapping *)blogModelMapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[BlogModel class]];
    [mapping addAttributeMappingsFromArray:@[@"identifier", @"title", @"summary", @"publishDate", @"updateDate", @"link", @"blogapp", @"diggs", @"views", @"comments"]];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"author" toKeyPath:@"authorModel" withMapping:[self authorModelMapping]]];
    return mapping;
}

- (RKObjectMapping *)authorModelMapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[AuthorModel class]];
    [mapping addAttributeMappingsFromArray:@[@"uri", @"name", @"avatar"]];
    return mapping;
}

@end
