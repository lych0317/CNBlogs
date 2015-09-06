//
//  CommentTableViewCell.h
//  CNBlogs
//
//  Created by 李远超 on 15/9/6.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommentModel;

@interface CommentTableViewCell : UITableViewCell

- (void)setupCellWithCommentModel:(CommentModel *)model;
- (CGFloat)cellHeightForCommentModel:(CommentModel *)model tableWidth:(CGFloat)width;

@end
