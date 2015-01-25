//
//  DataConverter.m
//  JieShuQuan
//
//  Created by Yang Xiaozhu on 14-8-27.
//  Copyright (c) 2014年 JNXZ. All rights reserved.
//

#import "DataConverter.h"
#import "Book.h"

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

// keys in Server API for Book
static const NSString *kBookname = @"name";
static const NSString *kBookauthors = @"authors";
static const NSString *kBookimageHref = @"image_href";
static const NSString *kBookdescription = @"description";
static const NSString *kBookauthorInfo = @"author_info";
static const NSString *kBookprice = @"price";
static const NSString *kBookpublisher = @"publisher";
static const NSString *kBookpublishDate = @"publish_date";
static const NSString *kBookId = @"douban_book_id";
static const NSString *kBookAvailable = @"available";

#pragma mark - keys in Core Data

// keys in CoreData for Book
static const NSString *kCDName = @"name";
static const NSString *kCDAuthors = @"authors";
static const NSString *kCDImageHref = @"imageHref";
static const NSString *kCDDescription = @"bookDescription";
static const NSString *kCDAuthorInfo = @"authorInfo";
static const NSString *kCDPrice = @"price";
static const NSString *kCDPublisher = @"publisher";
static const NSString *kCDBookId = @"bookId";
static const NSString *kCDPublishDate = @"publishDate";
static const NSString *kCDAvailability = @"availability";

@interface DataConverter ()

+ (NSMutableArray *)booksArrayFromUnserializedBooksData:(NSArray *)booksData;

@end

@implementation DataConverter

#pragma mark - Book

+ (NSMutableArray *)booksArrayFromDoubanSearchResults:(NSData *)searchResults
{
    id object = [NSJSONSerialization JSONObjectWithData:searchResults options:NSJSONReadingAllowFragments error:nil];
    if (!object)
        return nil;
    return [self booksArrayFromUnserializedBooksData:[object valueForKey:@"books"]];
}

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
    book.publishDate = [object valueForKey:(NSString *)kDBPubdate];
    book.bookId = [object valueForKey:(NSString *)kDBBookId];
    return book;
}

+ (Book *)bookFromServerBookObject:(id)object
{
    Book *book = [[Book alloc] init];
    
    book.bookName = [object valueForKey:(NSString *)kBookname];
    book.bookAuthors = [object valueForKey:(NSString *)kBookauthors];
    book.bookImageHref = [object valueForKey:(NSString *)kBookimageHref];
    book.bookDescription = [object valueForKey:(NSString *)kBookdescription];
    book.bookAuthorInfo = [object valueForKey:(NSString *)kBookauthorInfo];
    book.bookPrice = [object valueForKey:(NSString *)kBookprice];
    book.bookPublisher = [object valueForKey:(NSString *)kBookpublisher];
    book.publishDate = [object valueForKey:(NSString *)kBookpublishDate];
    book.bookId = [object valueForKey:(NSString *)kBookId];
    book.bookAvailability = [[object valueForKey:(NSString *)kBookAvailable] boolValue];
    return book;
}

+ (Book *)bookFromStoreObject:(id)storedBook
{
    Book *book = [[Book alloc] init];
    book.bookName = [storedBook valueForKey:(NSString *)kCDName];
    book.bookAuthors = [storedBook valueForKey:(NSString *)kCDAuthors];
    book.bookImageHref = [storedBook valueForKey:(NSString *)kCDImageHref];
    book.bookDescription = [storedBook valueForKey:(NSString *)kCDDescription];
    book.bookAuthorInfo = [storedBook valueForKey:(NSString *)kCDAuthorInfo];
    book.bookPrice = [storedBook valueForKey:(NSString *)kCDPrice];
    book.bookPublisher = [storedBook valueForKey:(NSString *)kCDPublisher];
    book.bookId = [storedBook valueForKey:(NSString *)kCDBookId];
    book.publishDate = [storedBook valueForKey:(NSString *)kCDPublishDate];
    book.bookAvailability = [[storedBook valueForKey:(NSString *)kCDAvailability] boolValue];
    return book;
}

+ (void)setManagedObject:(id)managedBook forBook:(Book *)book
{
    [managedBook setValue:book.bookName forKey:(NSString *)kCDName];
    [managedBook setValue:book.bookAuthors forKey:(NSString *)kCDAuthors];
    [managedBook setValue:book.bookImageHref  forKey:(NSString *)kCDImageHref];
    [managedBook setValue:book.bookDescription forKey:(NSString *)kCDDescription];
    [managedBook setValue:book.bookAuthorInfo forKey:(NSString *)kCDAuthorInfo];
    [managedBook setValue:book.bookPrice forKey:(NSString *)kCDPrice];
    [managedBook setValue:book.bookPublisher forKey:(NSString *)kCDPublisher];
    [managedBook setValue:book.bookId forKey:(NSString *)kCDBookId];
    [managedBook setValue:book.publishDate forKey:(NSString *)kCDPublishDate];
    [managedBook setValue:[NSNumber numberWithBool:book.bookAvailability] forKey:(NSString *)kCDAvailability];
}

#pragma mark - private methods

+ (NSMutableArray *)booksArrayFromUnserializedBooksData:(NSArray *)booksData
{
    NSMutableArray *booksArray = [NSMutableArray array];
    
    for (id item in booksData) {
        [booksArray addObject:[self bookFromDoubanBookObject:item]];
    }
    return booksArray;
}

@end
