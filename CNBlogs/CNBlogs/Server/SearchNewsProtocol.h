//
//  SearchNewsProtocol.h
//  CNBlogs
//
//  Created by 李远超 on 15/10/26.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "BaseProtocol.h"

@interface SearchNewsProtocol : BaseProtocol

- (void)getNewsWithKeyword:(NSString *)keyword page:(NSInteger)page success:(ProtocolSuccessBlock)success failure:(ProtocolFailureBlock)failure;

@end
