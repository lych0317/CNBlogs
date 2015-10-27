//
//  UIPageTableViewController.h
//  CNBlogs
//
//  Created by 李远超 on 15/9/7.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "UIBaseTableViewController.h"
#import "ProtocolUtil.h"
#import <MJRefresh/MJRefresh.h>

typedef void(^PageTableRequestDataSuccessBlock)(NSArray *array);
typedef void(^PageTableRequestDataFailureBlock)(NSError *error);

@interface UIPageTableViewController : UIBaseTableViewController

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger firstPage;

- (void)requestDataWithSuccess:(PageTableRequestDataSuccessBlock)success failure:(PageTableRequestDataFailureBlock)failure;

@end
