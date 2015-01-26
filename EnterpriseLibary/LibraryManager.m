//
//  UserManager.m
//  JieShuQuan
//
//  Created by Yang Xiaozhu on 14-9-11.
//  Copyright (c) 2014年 JNXZ. All rights reserved.
//

#import "LibraryManager.h"
#import "Library.h"
#import "LibraryStore.h"

static const NSString *kUDCurrentLibraryId = @"current_library_id";

@implementation LibraryManager

+ (void)saveLibraryToUserDefaults:(Library *)library
{
    [[NSUserDefaults standardUserDefaults] setObject:library.libraryId forKey:(NSString *)kUDCurrentLibraryId];
}

+ (Library *)currentLibrary
{
    NSString *libraryId = [[NSUserDefaults standardUserDefaults] objectForKey:(NSString *)kUDCurrentLibraryId];
    return (libraryId == nil) ? nil : [[LibraryStore sharedStore] libraryWithLibraryId:libraryId];
}
@end
