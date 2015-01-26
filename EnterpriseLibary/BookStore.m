//
//  BookStore.m
//  JieShuQuan
//
//  Created by Yang Xiaozhu on 14-9-2.
//  Copyright (c) 2014年 JNXZ. All rights reserved.
//

#import "BookStore.h"
#import "Book.h"
#import <CoreData/CoreData.h>
#import "DataConverter.h"
#import "LibraryManager.h"
#import "LibraryStore.h"
#import "Library.h"

@interface BookStore ()
{
    NSArray *storedBooks;
}
@end

@implementation BookStore

// keys in CoreData
static const NSString *kEntityName = @"Book";

static const NSString *kCDName = @"bookName";
static const NSString *kCDAuthors = @"bookAuthors";
static const NSString *kCDBookId = @"bookId";
static const NSString *kCDAvailability = @"bookAvailability";
static const NSString *kCDBookAddTime = @"bookAddTime";

+ (BookStore *)sharedStore
{
    static BookStore *sharedStore = nil;
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
        storedBooks = [self booksArrayFromStore:[self fetchBooksFromStore]];
    }
    return self;
}

- (NSArray *)storedBooks
{
    return storedBooks;
}

- (void)refreshStoredBooks
{
    storedBooks = [self booksArrayFromStore:[self fetchBooksFromStore]];
}

- (BOOL)storeHasBook:(Book *)book
{
    for (Book *item in storedBooks) {
        if ([item isSameBook:book]) {
            return YES;
        }
    }
    return NO;
}

- (void)deleteBookFromStore:(Book *)book
{
    for (NSManagedObject *item in [self fetchBooksFromStore]) {
        if ([[item valueForKey:(NSString *)kCDName] isEqualToString:book.bookName]
            && [[item valueForKey:(NSString *)kCDAuthors] isEqualToString:book.bookAuthors]) {
            [[self managedObjectContext] deleteObject:item];
            [self saveContext];
            [self refreshStoredBooks];
        }
    }
}

- (void)addBookToStore:(Book *)book
{
    NSManagedObject *newBook = [NSEntityDescription insertNewObjectForEntityForName:(NSString *)kEntityName inManagedObjectContext:[self managedObjectContext]];
    [self setBookPropertiesByBook:book forManagedBook:newBook];
    
    Library *library = [LibraryManager currentLibrary];
    NSArray *librariesArray = [[LibraryStore sharedStore] storedLibraryWithLibraryId:[library libraryId]];
    if ([librariesArray count]) {
        NSManagedObject *currentLibrary = librariesArray[0];
        NSMutableSet *booksSet = [currentLibrary mutableSetValueForKey:@"books"];
        [booksSet addObject:newBook];
    }
    
    [self saveContext];
    [[BookStore sharedStore] refreshStoredBooks];
}

- (void)emptyBookStoreForCurrentUser
{
    NSArray *userBooks = [self fetchBooksFromStore];
    for (NSManagedObject *book in userBooks) {
        [[self managedObjectContext] deleteObject:book];
    }
    [self saveContext];
}

- (void)changeStoredBookStatusWithBook:(Book *)book
{
    NSArray *booksArray = [self fetchBooksFromStore];
    for (id item in booksArray) {
        if ([book.bookId isEqualToString:[item valueForKey:(NSString *)kCDBookId]]) {
            [item setValue:[NSNumber numberWithBool:book.bookAvailability] forKey:(NSString *)kCDAvailability];
            [self saveContext];
            [[BookStore sharedStore] refreshStoredBooks];
            return;
        }
    }
}

#pragma mark - private methods

- (NSArray *)fetchBooksFromStore
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:(NSString *)kEntityName];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"library.libraryId == %@", [[LibraryManager currentLibrary] libraryId]];
//    [request setPredicate:predicate];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:(NSString *)kCDBookAddTime ascending:NO];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    return [[self managedObjectContext] executeFetchRequest:request error:nil];
}

- (NSMutableArray *)booksArrayFromStore:(NSArray *)array
{
    NSMutableArray *booksArray = [NSMutableArray array];
    for (NSManagedObject *storedBook in array) {
        Book *book = [DataConverter bookFromStoreObject:storedBook];
        [booksArray addObject:book];
    }
    return booksArray;
}

- (void)setBookPropertiesByBook:(Book *)book forManagedBook:(NSManagedObject *)managedBook
{
    [DataConverter setManagedObject:managedBook forBook:book];
}

@end
