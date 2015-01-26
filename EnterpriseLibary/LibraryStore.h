//
//  LibraryStore.h
//  EnterpriseLibary
//
//  Created by Yang Xiaozhu on 1/25/15.
//  Copyright (c) 2015 Xiaozhu-Jianing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Store.h"
@class Library;

@interface LibraryStore : Store

+ (LibraryStore *)sharedStore;
- (Library *)storedLibrary;
- (Library *)libraryWithLibraryId:(NSString *)libraryId;
- (NSArray *)storedLibraryWithLibraryId:(NSString *)libraryId;
- (void)addLibraryToLibraryStore:(Library *)library;

- (void)refreshStoredLibraries;

@end
