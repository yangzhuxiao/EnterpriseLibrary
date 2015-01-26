//
//  LibraryStore.m
//  EnterpriseLibary
//
//  Created by Yang Xiaozhu on 1/25/15.
//  Copyright (c) 2015 Xiaozhu-Jianing. All rights reserved.
//

#import "LibraryStore.h"
#import "Library.h"
#import "DataConverter.h"
#import "LibraryManager.h"
#import <CoreData/CoreData.h>

static const NSString *kEntityName = @"Library";

// keys in CoreData
static const NSString *kCDLibraryName = @"libraryName";
static const NSString *kCDLibraryId = @"libraryId";
static const NSString *kCDLibraryAdminId = @"libraryAdminId";

@interface LibraryStore ()
{
    Library *storedLibrary;
}
@end

@implementation LibraryStore

+ (LibraryStore *)sharedStore
{
    static LibraryStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[super allocWithZone:nil] init];
    }
    return sharedStore;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedStore];
}

- (id)init
{
    self = [super init];
    if (self) {
        storedLibrary = [self libraryFromStore:[self fetchLibrariesFromStore]];
    }
    return self;
}

- (Library *)storedLibrary
{
    return storedLibrary;
}

- (void)addLibraryToLibraryStore:(Library *)library
{
    NSManagedObject *newLibrary = [NSEntityDescription insertNewObjectForEntityForName:(NSString *)kEntityName inManagedObjectContext:[self managedObjectContext]];
    [self setLibraryPropertiesByLibrary:library forManagedBook:newLibrary];
    
    [self saveContext];
    [[LibraryStore sharedStore] refreshStoredLibraries];
}

- (void)setLibraryPropertiesByLibrary:(Library *)library forManagedBook:(NSManagedObject *)managedLibrary
{
    [DataConverter setManagedObject:managedLibrary forLibrary:library];
}

- (Library *)libraryFromStore:(NSArray *)array
{
    Library *library = [[Library alloc] init];
    for (NSManagedObject *managedLibrary in array) {
        library = [DataConverter libraryFromStoreObject:managedLibrary];
    }
    return library;
}

- (NSArray *)storedLibraryWithLibraryId:(NSString *)libraryId
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:(NSString *)kEntityName];
    //此处不能用kDBUserId代替Format中的user_id
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"libraryId==%@", libraryId];
    [request setPredicate:predicate];
    return [[self managedObjectContext] executeFetchRequest:request error:nil];
}

- (Library *)libraryWithLibraryId:(NSString *)libraryId
{
    if ([[self storedLibraryWithLibraryId:libraryId] count] == 0) {
        return nil;
    }
    NSManagedObject *library = [[self storedLibraryWithLibraryId:libraryId] objectAtIndex:0];
    return [DataConverter libraryFromStoreObject:library];
}

- (void)refreshStoredLibraries
{
    storedLibrary = [self libraryFromStore:[self fetchLibrariesFromStore]];
}

#pragma mark - private methods

- (NSArray *)fetchLibrariesFromStore
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:(NSString *)kEntityName];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"library.libraryId == %@", [[LibraryManager currentLibrary] libraryId]];
//    [request setPredicate:predicate];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:(NSString *)kCDLibraryId ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    return [[self managedObjectContext] executeFetchRequest:request error:nil];
}

@end
