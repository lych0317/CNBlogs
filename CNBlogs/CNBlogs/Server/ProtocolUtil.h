//
//  ProtocolUtil.h
//  CNBlogs
//
//  Created by 李远超 on 15/8/26.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import <RKXMLReaderSerialization/RKXMLReaderSerialization.h>

typedef void(^ProtocolSuccessBlock)(id data, id identifier);
typedef void(^ProtocolFailureBlock)(RKObjectRequestOperation *operation, NSError *error);

@interface ProtocolUtil : NSObject

+ (void)getBlogListWithPageIndex:(NSNumber *)index pageCount:(NSNumber *)count success:(ProtocolSuccessBlock)success failure:(ProtocolFailureBlock)failure;
+ (void)getBlogContentWithID:(NSNumber *)identifier success:(ProtocolSuccessBlock)success failure:(ProtocolFailureBlock)failure;
+ (void)getBloggerListWithSearchText:(NSString *)text success:(ProtocolSuccessBlock)success failure:(ProtocolFailureBlock)failure;
+ (void)getBlogListWithBlogapp:(NSString *)blogapp pageIndex:(NSNumber *)index pageCount:(NSNumber *)count success:(ProtocolSuccessBlock)success failure:(ProtocolFailureBlock)failure;

+ (void)getNewsListWithPageIndex:(NSNumber *)index pageCount:(NSNumber *)count success:(ProtocolSuccessBlock)success failure:(ProtocolFailureBlock)failure;

+ (void)getBloggerRecommendListWithPageIndex:(NSNumber *)index pageCount:(NSNumber *)count success:(ProtocolSuccessBlock)success failure:(ProtocolFailureBlock)failure;
+ (void)getViewIn48HListWithCount:(NSNumber *)count success:(ProtocolSuccessBlock)success failure:(ProtocolFailureBlock)failure;
+ (void)getRecommendIn10DListWithCount:(NSNumber *)count success:(ProtocolSuccessBlock)success failure:(ProtocolFailureBlock)failure;
+ (void)getNewsRecommendListWithPageIndex:(NSNumber *)index pageCount:(NSNumber *)count success:(ProtocolSuccessBlock)success failure:(ProtocolFailureBlock)failure;

@end
