//
//  BloggerDAO.m
//  CNBlogs
//
//  Created by 李远超 on 15/9/1.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "BloggerDAO.h"
#import "BloggerEntity.h"

@implementation BloggerDAO

- (NSInteger)insertBlogger:(BloggerModel *)bloggerModel {
    NSManagedObjectContext *context = [self managedObjectContext];

    BloggerEntity *bloggerEntity = [NSEntityDescription insertNewObjectForEntityForName:@"BloggerEntity" inManagedObjectContext:context];
    [bloggerEntity setValue:bloggerModel.identifier forKey:@"identifier"];
    [bloggerEntity setValue:bloggerModel.title forKey:@"title"];
    [bloggerEntity setValue:bloggerModel.updateDate forKey:@"updateDate"];
    [bloggerEntity setValue:bloggerModel.link forKey:@"link"];
    [bloggerEntity setValue:bloggerModel.blogapp forKey:@"blogapp"];
    [bloggerEntity setValue:bloggerModel.avatar forKey:@"avatar"];
    [bloggerEntity setValue:bloggerModel.postCount forKey:@"postCount"];
    [bloggerEntity setValue:[NSDate date] forKey:@"likeDate"];

    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        return -1;
    }
    return 0;
}

- (NSInteger)deleteBlogger:(BloggerModel *)bloggerModel {
    NSManagedObjectContext *context = [self managedObjectContext];

    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"BloggerEntity" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = entityDescription;

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier = %@", bloggerModel.identifier];
    fetchRequest.predicate = predicate;

    NSError *error = nil;
    NSArray *listData = [context executeFetchRequest:fetchRequest error:&error];
    if (listData.count > 0 && !error) {
        BloggerEntity *bloggerEntity = listData.lastObject;
        [context deleteObject:bloggerEntity];

        if ([context hasChanges] && ![context save:&error]) {
            return -1;
        }
    } else {
        return -1;
    }
    return 0;
}

- (NSArray *)findAllBlogger {
    NSManagedObjectContext *context = [self managedObjectContext];

    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BloggerEntity" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = entity;

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"likeDate" ascending:NO];
    fetchRequest.sortDescriptors = @[sortDescriptor];

    NSError *error = nil;
    NSArray *listData = [context executeFetchRequest:fetchRequest error:&error];

    NSMutableArray *retArray = [NSMutableArray array];

    for (BloggerEntity *bloggerEntity in listData) {
        BloggerModel *bloggerModel = [[BloggerModel alloc] init];
        bloggerModel.identifier = bloggerEntity.identifier;
        bloggerModel.title = bloggerEntity.title;
        bloggerModel.updateDate = bloggerEntity.updateDate;
        bloggerModel.link = bloggerEntity.link;
        bloggerModel.blogapp = bloggerEntity.blogapp;
        bloggerModel.avatar = bloggerEntity.avatar;
        bloggerModel.postCount = bloggerEntity.postCount;

        [retArray addObject:bloggerModel];
    }
    return retArray;
}

@end
