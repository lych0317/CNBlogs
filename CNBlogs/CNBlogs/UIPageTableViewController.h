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

@interface UIPageTableViewController : UIBaseTableViewController

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, copy) ProtocolSuccessBlock successBlock;
@property (nonatomic, copy) ProtocolFailureBlock failureBlock;

- (void)requestData;

@end
