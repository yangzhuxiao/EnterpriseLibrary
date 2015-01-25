//
//  DataConverter.h
//  JieShuQuan
//
//  Created by Yang Xiaozhu on 14-8-27.
//  Copyright (c) 2014年 JNXZ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Book;

@interface DataConverter : NSObject

// books
+ (NSMutableArray *)booksArrayFromDoubanSearchResults:(NSData *)searchResults;
+ (Book *)bookFromServerBookObject:(id)object;
+ (Book *)bookFromStoreObject:(id)storedBook;
+ (void)setManagedObject:(id)object forBook:(Book *)book;
+ (Book *)bookFromDoubanBookObject:(id)object;

@end
