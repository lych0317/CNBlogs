//
//  NewsDAO.m
//  CNBlogs
//
//  Created by 李远超 on 15/9/2.
//  Copyright (c) 2015年 liyc. All rights reserved.
//

#import "NewsDAO.h"
#import "NewsModel.h"
#import "NewsContentModel.h"
#import "NewsEntity.h"
#import "NewsContentEntity.h"

@implementation NewsDAO

- (NSInteger)insertNews:(NewsModel *)newsModel {
    NSManagedObjectContext *context = [self managedObjectContext];

    NewsContentEntity *contentEntity = [NSEntityDescription insertNewObjectForEntityForName:@"NewsContentEntity" inManagedObjectContext:context];
    contentEntity.content = newsModel.contentModel.content;

    NewsEntity *newsEntity = [NSEntityDescription insertNewObjectForEntityForName:@"NewsEntity" inManagedObjectContext:context];
    [newsEntity setValue:newsModel.identifier forKey:@"identifier"];
    [newsEntity setValue:newsModel.title forKey:@"title"];
    [newsEntity setValue:newsModel.summary forKey:@"summary"];
    [newsEntity setValue:newsModel.publishDate forKey:@"publishDate"];
    [newsEntity setValue:newsModel.updateDate forKey:@"updateDate"];
    [newsEntity setValue:newsModel.link forKey:@"link"];
    [newsEntity setValue:newsModel.diggs forKey:@"diggs"];
    [newsEntity setValue:newsModel.views forKey:@"views"];
    [newsEntity setValue:newsModel.comments forKey:@"comments"];
    [newsEntity setValue:newsModel.topic forKey:@"topic"];
    [newsEntity setValue:newsModel.topicIcon forKey:@"topicIcon"];
    [newsEntity setValue:newsModel.sourceName forKey:@"sourceName"];
    [newsEntity setValue:contentEntity forKey:@"contentEntity"];

    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        MyLogError(@"插入news失败：%@", error.description);
        return -1;
    }
    return 0;
}

- (NSInteger)deleteNews:(NewsModel *)newsModel {
    NSManagedObjectContext *context = [self managedObjectContext];

    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"NewsEntity" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier = %@", newsModel.identifier];

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = entityDescription;
    fetchRequest.predicate = predicate;

    NSError *error = nil;
    NSArray *listData = [context executeFetchRequest:fetchRequest error:&error];
    if (listData.count > 0) {
        NewsEntity *newsEntity = listData.lastObject;
        [context deleteObject:newsEntity];

        if ([context hasChanges] && ![context save:&error]) {
            return -1;
        }
    } else if (error) {
        MyLogError(@"查询将要删除的news时失败：%@", error.description);
        return -1;
    } else {
        MyLogError(@"未查询到将要删除的news");
        return -1;
    }
    return 0;
}

- (NewsModel *)findNews:(NewsModel *)newsModel {
    NSManagedObjectContext *context = [self managedObjectContext];

    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"NewsEntity" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier = %@", newsModel.identifier];

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = entityDescription;
    fetchRequest.predicate = predicate;

    NSError *error = nil;
    NSArray *listData = [context executeFetchRequest:fetchRequest error:&error];
    if (listData.count > 0) {
        return [self newsModelFromEntity:listData.lastObject];
    } else if (error) {
        MyLogError(@"查询news失败：%@", error.description);
    }
    return nil;
}

- (NSArray *)findAllNews {
    NSManagedObjectContext *context = [self managedObjectContext];

    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"NewsEntity" inManagedObjectContext:context];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"likeDate" ascending:NO];

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = entityDescription;
    fetchRequest.sortDescriptors = @[sortDescriptor];

    NSError *error = nil;
    NSArray *listData = [context executeFetchRequest:fetchRequest error:&error];

    if (listData.count > 0) {
        NSMutableArray *retArray = [NSMutableArray arrayWithCapacity:listData.count];
        for (NewsEntity *newsEntity in listData) {
            [retArray addObject:[self newsModelFromEntity:newsEntity]];
        }
        return retArray;
    } else if (error) {
        MyLogError(@"查询news失败： %@", error.description);
    }
    return @[];
}

- (NewsModel *)newsModelFromEntity:(NewsEntity *)newsEntity {
    NewsModel *newsModel = [[NewsModel alloc] init];
    newsModel.identifier = newsEntity.identifier;
    newsModel.title = newsEntity.title;
    newsModel.summary = newsEntity.summary;
    newsModel.publishDate = newsEntity.publishDate;
    newsModel.updateDate = newsEntity.updateDate;
    newsModel.link = newsEntity.link;
    newsModel.diggs = newsEntity.diggs;
    newsModel.views = newsEntity.views;
    newsModel.comments = newsEntity.comments;
    newsModel.topic = newsEntity.topic;
    newsModel.topicIcon = newsEntity.topicIcon;
    newsModel.sourceName = newsEntity.sourceName;

    NewsContentModel *contentModel = [[NewsContentModel alloc] init];
    contentModel.content = newsEntity.contentEntity.content;

    newsModel.contentModel = contentModel;

    return newsModel;
}

@end
