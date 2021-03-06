//
//  UserStore.m
//  JieShuQuan
//
//  Created by Jianning Zheng on 9/6/14.
//  Copyright (c) 2014 JNXZ. All rights reserved.
//

#import "UserStore.h"
#import <CoreData/CoreData.h>
#import "User.h"
#import "DataConverter.h"

static const NSString *kEntityName = @"User";

@implementation UserStore

+ (UserStore *)sharedStore
{
    static UserStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[super allocWithZone:nil] init];
    }
    return sharedStore;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedStore];
}

- (void)saveUserToCoreData:(User *)user
{
    NSManagedObject *managedObject;
    NSArray *users = [self storedUsersWithUserId:user.userId];
    if ([users count]==0) {
        managedObject = [NSEntityDescription insertNewObjectForEntityForName:(NSString *)kEntityName inManagedObjectContext:[self managedObjectContext]];
    } else {
        managedObject = [users objectAtIndex:0];
    }
    [DataConverter setManagedObject:managedObject forUser:user];
    [self saveContext];
}

- (NSArray *)storedUsersWithUserId:(NSString *)userId
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:(NSString *)kEntityName];
    //此处不能用kDBUserId代替Format中的user_id
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"user_id==%@", userId];
    [request setPredicate:predicate];
    return [[self managedObjectContext] executeFetchRequest:request error:nil];
}

- (User *)userWithUserId:(NSString *)userId
{
    if ([[self storedUsersWithUserId:userId] count] == 0) {
        return nil;
    }
    NSManagedObject *storedUser = [[self storedUsersWithUserId:userId] objectAtIndex:0];
    return [DataConverter userFromManagedObject:storedUser];
}

@end
