//
//  DataConverter.h
//  JieShuQuan
//
//  Created by Yang Xiaozhu on 14-8-27.
//  Copyright (c) 2014年 JNXZ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Book;
@class Library;
@class User;

@interface DataConverter : NSObject

// library
+ (Library *)libraryFromStoreObject:(id)storedLibrary;
+ (void)setManagedObject:(id)managedLibrary forLibrary:(Library *)library;

// book
+ (Book *)bookFromDoubanBookObject:(id)object;
+ (Book *)bookFromStoreObject:(id)storedBook;
+ (void)setManagedObject:(id)managedBook forBook:(Book *)book;

// users
+ (User *)userFromHTTPResponse:(id)object;
+ (User *)userFromManagedObject:(id)storedUser;
+ (void)setManagedObject:(id)object forUser:(User *)user;

@end
