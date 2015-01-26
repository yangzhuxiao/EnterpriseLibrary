//
//  LibraryInfoViewController.m
//  EnterpriseLibary
//
//  Created by Yang Xiaozhu on 1/25/15.
//  Copyright (c) 2015 Xiaozhu-Jianing. All rights reserved.
//

#import "LibraryInfoViewController.h"
#import "Library.h"
#import "LibraryManager.h"
#import "LibraryStore.h"

@interface LibraryInfoViewController ()

@end

@implementation LibraryInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Library *testLibrary = [[Library alloc] init];
    testLibrary.libraryId = @"007";
    testLibrary.libraryName = @"James Bond";
    testLibrary.libraryAdminId = @"009";
    
    [LibraryManager saveLibraryToUserDefaults:testLibrary];
    
    
    [[LibraryStore sharedStore] addLibraryToLibraryStore:testLibrary];
}

@end
