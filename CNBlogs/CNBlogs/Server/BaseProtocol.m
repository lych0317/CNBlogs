//
//  BaseProtocol.m
//  CNBlogs
//
//  Created by 李远超 on 15/10/26.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "BaseProtocol.h"

#define BaseURL @"http://123.57.79.48:5000/"

@implementation BaseProtocol

- (NSString *)setupParametersWithSubURLString:(NSString *)urlString {
    NSString *appverPart = [NSString stringWithFormat:@"appver=%@", App_Version];

    NSMutableString *parameters = [NSMutableString stringWithFormat:@"%@?%@", urlString, appverPart];
    return parameters;
}

- (NSIndexSet *)statusCodes {
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    [indexSet addIndexes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [indexSet addIndexes:RKStatusCodeIndexSetForClass(RKStatusCodeClassClientError)];
    [indexSet addIndexes:RKStatusCodeIndexSetForClass(RKStatusCodeClassServerError)];
    return indexSet;
}

- (void)getObjectsAtPath:(NSString *)path parameterDictionary:(NSDictionary *)parameterDictionary identifier:(id)identifier objectMapping:(RKObjectMapping *)objectMapping success:(ProtocolSuccessBlock)success failure:(ProtocolFailureBlock)failure {
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:objectMapping method:RKRequestMethodGET pathPattern:nil keyPath:nil statusCodes:[self statusCodes]];

    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:BaseURL]];
    manager.requestSerializationMIMEType = RKMIMETypeJSON;
    [manager addResponseDescriptor:responseDescriptor];

    [manager getObjectsAtPath:[self setupParametersWithSubURLString:path] parameters:parameterDictionary success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        [self setupResult:mappingResult identifier:identifier success:success failure:failure];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)setupResult:(RKMappingResult *)result identifier:(id)identifier success:(ProtocolSuccessBlock)success failure:(ProtocolFailureBlock)failure {
    BaseResult *baseResult = result.firstObject;
    NSError *error = nil;
    if (!baseResult) {
        error = [NSError errorWithDomain:NSLocalizedString(@"请求失败", @"") code:1 userInfo:nil];
    } else {
        error = [self errorWithResponseCode:baseResult.status];
    }
    if (error) {
        if (failure) {
            failure(error);
        }
    } else if (success) {
        success(baseResult.data, identifier);
    }
}

- (NSError *)errorWithResponseCode:(NSNumber *)code {
    NSError *error = nil;
    switch ([code intValue]) {
        case 1:
            error = [NSError errorWithDomain:NSLocalizedString(@"请求失败", @"") code:1 userInfo:nil];
            break;
        default:
            break;
    }

    return error;
}

#pragma mark - 

- (RKObjectMapping *)baseResultMapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[BaseResult class]];
    [mapping addAttributeMappingsFromArray:@[@"status"]];
    return mapping;
}

@end
