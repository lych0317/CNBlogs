//
//  BlogDAO.m
//  CNBlogs
//
//  Created by 李远超 on 15/9/2.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "BlogDAO.h"
#import "BlogEntiry.h"
#import "AuthorEntity.h"
#import "BlogContentEntity.h"

@implementation BlogDAO

- (NSInteger)insertBlog:(BlogModel *)blogModel {
    NSManagedObjectContext *context = [self managedObjectContext];

    AuthorEntity *authorEntity = [NSEntityDescription insertNewObjectForEntityForName:@"AuthorEntity" inManagedObjectContext:context];
    authorEntity.uri = blogModel.authorModel.uri;
    authorEntity.name = blogModel.authorModel.name;
    authorEntity.avatar = blogModel.authorModel.avatar;

    BlogContentEntity *contentEntity = [NSEntityDescription insertNewObjectForEntityForName:@"BlogContentEntity" inManagedObjectContext:context];
    contentEntity.content = blogModel.contentModel.content;

    BlogEntiry *blogEntity = [NSEntityDescription insertNewObjectForEntityForName:@"BlogEntiry" inManagedObjectContext:context];
    [blogEntity setValue:blogModel.identifier forKey:@"identifier"];
    [blogEntity setValue:blogModel.title forKey:@"title"];
    [blogEntity setValue:blogModel.summary forKey:@"summary"];
    [blogEntity setValue:blogModel.publishDate forKey:@"publishDate"];
    [blogEntity setValue:blogModel.updateDate forKey:@"updateDate"];
    [blogEntity setValue:blogModel.link forKey:@"link"];
    [blogEntity setValue:blogModel.blogapp forKey:@"blogapp"];
    [blogEntity setValue:blogModel.diggs forKey:@"diggs"];
    [blogEntity setValue:blogModel.views forKey:@"views"];
    [blogEntity setValue:blogModel.comments forKey:@"comments"];
    [blogEntity setValue:[NSDate date] forKey:@"likeDate"];
    [blogEntity setValue:authorEntity forKey:@"authorEntity"];
    [blogEntity setValue:contentEntity forKey:@"contentEntity"];

    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        MyLogError(@"插入blog失败：%@", error.description);
        return -1;
    }
    return 0;
}

- (NSInteger)deleteBlog:(BlogModel *)blogModel {
    NSManagedObjectContext *context = [self managedObjectContext];

    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"BlogEntiry" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier = %@", blogModel.identifier];

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = entityDescription;
    fetchRequest.predicate = predicate;

    NSError *error = nil;

    NSArray *listData = [context executeFetchRequest:fetchRequest error:&error];
    if (listData.count > 0) {
        BlogEntiry *blogEntity = listData.lastObject;
        [context deleteObject:blogEntity];

        if ([context hasChanges] && ![context save:&error]) {
            MyLogError(@"删除blog失败：%@", error.description);
            return -1;
        }
    } else if (error) {
        MyLogError(@"查询将要删除的blog时失败：%@", error.description);
        return -1;
    } else {
        MyLogError(@"未查询到将要删除的blog");
        return -1;
    }
    return 0;
}

- (BlogModel *)findBlog:(BlogModel *)blogModel {
    NSManagedObjectContext *context = [self managedObjectContext];

    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"BlogEntiry" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier = %@", blogModel.identifier];

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = entityDescription;
    fetchRequest.predicate = predicate;

    NSError *error = nil;
    NSArray *listData = [context executeFetchRequest:fetchRequest error:&error];
    if (listData.count > 0) {
        return [self blogModelFromEntity:listData.firstObject];
    } else if (error) {
        MyLogError(@"查询blog失败：%@", error.description);
    }
    return nil;
}

- (NSArray *)findAllBlog {
    NSManagedObjectContext *context = [self managedObjectContext];

    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"BlogEntiry" inManagedObjectContext:context];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"likeDate" ascending:NO];

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = entityDescription;
    fetchRequest.sortDescriptors = @[sortDescriptor];

    NSError *error = nil;
    NSArray *listData = [context executeFetchRequest:fetchRequest error:&error];

    if (listData.count > 0) {
        NSMutableArray *retArray = [NSMutableArray arrayWithCapacity:listData.count];
        for (BlogEntiry *blogEntity in listData) {
            [retArray addObject:[self blogModelFromEntity:blogEntity]];
        }
        return retArray;
    } else if (error) {
        MyLogError(@"查询blog失败：%@", error.description);
    }
    return @[];
}

- (BlogModel *)blogModelFromEntity:(BlogEntiry *)blogEntity {
    BlogModel *blogModel = [[BlogModel alloc] init];
    blogModel.identifier = blogEntity.identifier;
    blogModel.title = blogEntity.title;
    blogModel.summary = blogEntity.summary;
    blogModel.publishDate = blogEntity.publishDate;
    blogModel.updateDate = blogEntity.updateDate;
    blogModel.link = blogEntity.link;
    blogModel.blogapp = blogEntity.blogapp;
    blogModel.diggs = blogEntity.diggs;
    blogModel.views = blogEntity.views;
    blogModel.comments = blogEntity.comments;

    AuthorModel *authorModel = [[AuthorModel alloc] init];
    authorModel.uri = blogEntity.authorEntity.uri;
    authorModel.name = blogEntity.authorEntity.name;
    authorModel.avatar = blogEntity.authorEntity.avatar;

    blogModel.authorModel = authorModel;

    BlogContentModel *contentModel = [[BlogContentModel alloc] init];
    contentModel.content = blogEntity.contentEntity.content;

    blogModel.contentModel = contentModel;

    return blogModel;
}

@end
