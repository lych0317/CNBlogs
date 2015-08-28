//
//  BloggerTableViewCell.h
//  CNBlogs
//
//  Created by 李远超 on 15/8/27.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BloggerTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *updatedLabel;
@property (weak, nonatomic) IBOutlet UILabel *postCountLabel;

@end
