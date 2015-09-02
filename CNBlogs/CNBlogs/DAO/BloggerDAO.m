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
        MyLogError(@"插入blogger失败：%@", error.description);
        return -1;
    }
    return 0;
}

- (NSInteger)deleteBlogger:(BloggerModel *)bloggerModel {
    NSManagedObjectContext *context = [self managedObjectContext];

    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"BloggerEntity" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier = %@", bloggerModel.identifier];

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = entityDescription;
    fetchRequest.predicate = predicate;

    NSError *error = nil;
    NSArray *listData = [context executeFetchRequest:fetchRequest error:&error];
    if (listData.count > 0 && !error) {
        BloggerEntity *bloggerEntity = listData.lastObject;
        [context deleteObject:bloggerEntity];

        if ([context hasChanges] && ![context save:&error]) {
            MyLogError(@"删除blogger失败：%@", error.description);
            return -1;
        }
    } else if (error) {
        MyLogError(@"在查询将要删除的blogger时失败：%@", error.description);
        return -1;
    } else {
        MyLogError(@"未查询到将要删除的blogger");
        return -1;
    }
    return 0;
}

- (BloggerModel *)findBlogger:(BloggerModel *)bloggerModel {
    NSManagedObjectContext *context = [self managedObjectContext];

    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"BloggerEntity" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier = %@", bloggerModel.identifier];

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = entityDescription;
    fetchRequest.predicate = predicate;

    NSError *error = nil;
    NSArray *listData = [context executeFetchRequest:fetchRequest error:&error];
    if (listData.count > 0) {
        return [self bloggerModelFromEntity:listData.firstObject];
    } else if (error) {
        MyLogError(@"查询blog失败：%@", error.description);
    }
    return nil;
}

- (NSArray *)findAllBlogger {
    NSManagedObjectContext *context = [self managedObjectContext];

    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BloggerEntity" inManagedObjectContext:context];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"likeDate" ascending:NO];

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = entity;
    fetchRequest.sortDescriptors = @[sortDescriptor];

    NSError *error = nil;
    NSArray *listData = [context executeFetchRequest:fetchRequest error:&error];

    if (listData.count > 0) {
        NSMutableArray *retArray = [NSMutableArray arrayWithCapacity:listData.count];
        for (BloggerEntity *bloggerEntity in listData) {
            [retArray addObject:[self bloggerModelFromEntity:bloggerEntity]];
        }
        return retArray;
    } else if (error) {
        MyLogError(@"查询blogger失败：%@", error.description);
    }
    return @[];
}

- (BloggerModel *)bloggerModelFromEntity:(BloggerEntity *)bloggerEntity {
    BloggerModel *bloggerModel = [[BloggerModel alloc] init];
    bloggerModel.identifier = bloggerEntity.identifier;
    bloggerModel.title = bloggerEntity.title;
    bloggerModel.updateDate = bloggerEntity.updateDate;
    bloggerModel.link = bloggerEntity.link;
    bloggerModel.blogapp = bloggerEntity.blogapp;
    bloggerModel.avatar = bloggerEntity.avatar;
    bloggerModel.postCount = bloggerEntity.postCount;
    return bloggerModel;
}

@end
