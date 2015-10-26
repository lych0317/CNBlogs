//
//  BaseProtocol.h
//  CNBlogs
//
//  Created by 李远超 on 15/10/26.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseResult.h"
#import <RestKit/RestKit.h>

typedef void(^ProtocolSuccessBlock)(id data, id identifier);
typedef void(^ProtocolFailureBlock)(NSError *error);

@interface BaseProtocol : NSObject

- (void)getObjectsAtPath:(NSString *)path
     parameterDictionary:(NSDictionary *)parameterDictionary
              identifier:(id)identifier
           objectMapping:(RKObjectMapping *)objectMapping
                 success:(ProtocolSuccessBlock)success
                 failure:(ProtocolFailureBlock)failure;

#pragma mark - 

- (RKObjectMapping *)baseResultMapping;

@end
