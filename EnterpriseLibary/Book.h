//
//  Book.h
//  JieShuQuan
//
//  Created by Jianning Zheng on 8/24/14.
//  Copyright (c) 2014 JNXZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

@property (copy, nonatomic) NSString *libraryId;

@property (copy, nonatomic) NSString *bookName;
@property (copy, nonatomic) NSString *bookAuthors;
@property (copy, nonatomic) NSString *bookImageHref;
@property (copy, nonatomic) NSString *bookDescription;
@property (copy, nonatomic) NSString *bookAuthorInfo;
@property (copy, nonatomic) NSString *bookPrice;
@property (copy, nonatomic) NSString *bookPublisher;
@property (copy, nonatomic) NSString *bookPublishDate;
@property (copy, nonatomic) NSString *bookId;
@property (assign, nonatomic) BOOL bookAvailability;

- (BOOL)isSameBook:(Book *)book;

@end
