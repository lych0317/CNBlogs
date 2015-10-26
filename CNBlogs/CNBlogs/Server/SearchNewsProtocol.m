//
//  SearchNewsProtocol.m
//  CNBlogs
//
//  Created by 李远超 on 15/10/26.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "SearchNewsProtocol.h"
#import "NewsModel.h"

@implementation SearchNewsProtocol

- (void)getNewsWithKeyword:(NSString *)keyword page:(NSInteger)page success:(ProtocolSuccessBlock)success failure:(ProtocolFailureBlock)failure {
    RKObjectMapping *responseMapping = [self baseResultMapping];
    [responseMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"data" toKeyPath:@"data" withMapping:[self newsModelMapping]]];

    [self getObjectsAtPath:@"search/news" parameterDictionary:@{@"keyword": keyword, @"page": @(page)} identifier:nil objectMapping:responseMapping success:success failure:failure];
}

- (RKObjectMapping *)newsModelMapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[NewsModel class]];
    [mapping addAttributeMappingsFromArray:@[@"identifier", @"title", @"summary", @"publishDate", @"updateDate", @"link", @"diggs", @"views", @"comments"]];
    return mapping;
}

@end
