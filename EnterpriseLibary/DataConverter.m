//
//  DataConverter.m
//  JieShuQuan
//
//  Created by Yang Xiaozhu on 14-8-27.
//  Copyright (c) 2014年 JNXZ. All rights reserved.
//

#import "DataConverter.h"
#import "Library.h"
#import "Book.h"
#import "LibraryManager.h"

#pragma mark - keys in API
// keys in Douban API
static const NSString *kDBTitle = @"title";
static const NSString *kDBAuthor = @"author";
static const NSString *kDBImageHref = @"image";
static const NSString *kDBSummary = @"summary";
static const NSString *kDBAuthorIntro = @"author_intro";
static const NSString *kDBPrice = @"price";
static const NSString *kDBPublisher = @"publisher";
static const NSString *kDBPubdate = @"pubdate";
static const NSString *kDBBookId = @"id";
static const NSString *kBookLibraryId = @"library";

#pragma mark - keys in Core Data
// keys in CoreData for Library
static const NSString *kCDLibraryName = @"libraryName";
static const NSString *kCDLibraryId = @"libraryId";
static const NSString *kCDLibraryAdminId = @"libraryAdminId";

// keys in CoreData for Book
static const NSString *kCDBookName = @"bookName";
static const NSString *kCDBookAuthors = @"bookAuthors";
static const NSString *kCDBookImageHref = @"bookImageHref";
static const NSString *kCDBookDescription = @"bookDescription";
static const NSString *kCDBookAuthorInfo = @"bookAuthorInfo";
static const NSString *kCDBookPrice = @"bookPrice";
static const NSString *kCDBookPublisher = @"bookPublisher";
static const NSString *kCDBookId = @"bookId";
static const NSString *kCDBookPublishDate = @"bookPublishDate";
static const NSString *kCDBookAvailability = @"bookAvailability";

@implementation DataConverter

#pragma mark - Library

+ (Library *)libraryFromStoreObject:(id)storedLibrary
{
    Library *library = [[Library alloc] init];
    library.libraryName = [storedLibrary valueForKey:(NSString *)kCDLibraryName];
    library.libraryId = [storedLibrary valueForKey:(NSString *)kCDLibraryId];
    library.libraryAdminId = [storedLibrary valueForKey:(NSString *)kCDLibraryAdminId];
    return library;
}

+ (void)setManagedObject:(id)managedLibrary forLibrary:(Library *)library
{
    [managedLibrary setValue:library.libraryName forKey:(NSString *)kCDLibraryName];
    [managedLibrary setValue:library.libraryId forKey:(NSString *)kCDLibraryId];
    [managedLibrary setValue:library.libraryAdminId forKey:(NSString *)kCDLibraryAdminId];
}

#pragma mark - Book

+ (Book *)bookFromDoubanBookObject:(id)object
{
    Book *book = [[Book alloc] init];
    book.bookName = [object valueForKey:(NSString *)kDBTitle];
    book.bookAuthors = [[object valueForKey:(NSString *)kDBAuthor] componentsJoinedByString:@","];
    book.bookImageHref = [object valueForKey:(NSString *)kDBImageHref];
    book.bookDescription = [object valueForKey:(NSString *)kDBSummary];
    book.bookAuthorInfo = [object valueForKey:(NSString *)kDBAuthorIntro];
    book.bookPrice = [object valueForKey:(NSString *)kDBPrice];
    book.bookPublisher = [object valueForKey:(NSString *)kDBPublisher];
    book.bookPublishDate = [object valueForKey:(NSString *)kDBPubdate];
    book.bookId = [object valueForKey:(NSString *)kDBBookId];
    
    book.libraryId = [object valueForKey:(NSString *)[[LibraryManager currentLibrary] libraryId]];
    return book;
}

+ (Book *)bookFromStoreObject:(id)storedBook
{
    Book *book = [[Book alloc] init];
    book.bookName = [storedBook valueForKey:(NSString *)kCDBookName];
    book.bookAuthors = [storedBook valueForKey:(NSString *)kCDBookAuthors];
    book.bookImageHref = [storedBook valueForKey:(NSString *)kCDBookImageHref];
    book.bookDescription = [storedBook valueForKey:(NSString *)kCDBookDescription];
    book.bookAuthorInfo = [storedBook valueForKey:(NSString *)kCDBookAuthorInfo];
    book.bookPrice = [storedBook valueForKey:(NSString *)kCDBookPrice];
    book.bookPublisher = [storedBook valueForKey:(NSString *)kCDBookPublisher];
    book.bookId = [storedBook valueForKey:(NSString *)kCDBookId];
    book.bookPublishDate = [storedBook valueForKey:(NSString *)kCDBookPublishDate];
    book.bookAvailability = [[storedBook valueForKey:(NSString *)kCDBookAvailability] boolValue];
    return book;
}

+ (void)setManagedObject:(id)managedBook forBook:(Book *)book
{
    [managedBook setValue:book.bookName forKey:(NSString *)kCDBookName];
    [managedBook setValue:book.bookAuthors forKey:(NSString *)kCDBookAuthors];
    [managedBook setValue:book.bookImageHref forKey:(NSString *)kCDBookImageHref];
    [managedBook setValue:book.bookDescription forKey:(NSString *)kCDBookDescription];
    [managedBook setValue:book.bookAuthorInfo forKey:(NSString *)kCDBookAuthorInfo];
    [managedBook setValue:book.bookPrice forKey:(NSString *)kCDBookPrice];
    [managedBook setValue:book.bookPublisher forKey:(NSString *)kCDBookPublisher];
    [managedBook setValue:book.bookId forKey:(NSString *)kCDBookId];
    [managedBook setValue:book.bookPublishDate forKey:(NSString *)kCDBookPublishDate];
    [managedBook setValue:[NSNumber numberWithBool:book.bookAvailability] forKey:(NSString *)kCDBookAvailability];
}

@end
