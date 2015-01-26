//
//  Book.m
//  JieShuQuan
//
//  Created by Jianning Zheng on 8/24/14.
//  Copyright (c) 2014 JNXZ. All rights reserved.
//

#import "Book.h"

@implementation Book

- (BOOL)isSameBook:(Book *)book
{
    return [self.bookId isEqualToString:book.bookId];
}

@end
