//
//  CommentTableViewCell.m
//  CNBlogs
//
//  Created by 李远超 on 15/9/6.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "CommentModel.h"

@interface CommentTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *publishDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation CommentTableViewCell

- (void)setupCellWithCommentModel:(CommentModel *)model {
    self.authorLabel.text = model.authorModel.name;
    self.publishDateLabel.text = [model.publishDate stringWithFormate:yyMMddHHmm];
    self.contentLabel.text = [model.content deleteHTMLTag];
}

- (CGFloat)cellHeightForCommentModel:(CommentModel *)model tableWidth:(CGFloat)width {
    [self setupCellWithCommentModel:model];
    self.contentLabel.preferredMaxLayoutWidth = width - 20;
    return [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
}

@end
