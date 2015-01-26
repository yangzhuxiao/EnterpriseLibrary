//
//  AddBookViewController.m
//  EnterpriseLibary
//
//  Created by Yang Xiaozhu on 1/25/15.
//  Copyright (c) 2015 Xiaozhu-Jianing. All rights reserved.
//

#import "BooksTableViewController.h"
#import "CustomActivityIndicator.h"
#import "CustomAlert.h"
#import "DoubanHeaders.h"
#import "JsonDataFetcher.h"
#import "DataConverter.h"
#import "Book.h"
#import "BookTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "BookStore.h"

@interface BooksTableViewController ()
{
    UIView *searchBarWrapperView;
    UISearchController *searchController;
    NSMutableArray *booksArray;
}
@end

@implementation BooksTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTableViewData];
}

- (void)loadTableViewData
{
    booksArray = [[[BookStore sharedStore] storedBooks] mutableCopy];
}

- (IBAction)addBook:(id)sender {
    [self scanBarCode];
}

- (void)scanBarCode
{
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    reader.tracksSymbols = YES;
    
    ZBarImageScanner *scanner = reader.scanner;
    // EXAMPLE: disable rarely used I2/5 to improve performance
    [scanner setSymbology: ZBAR_I25 config: ZBAR_CFG_ENABLE to: 0];
    
    [self presentViewController:reader animated:YES completion:nil];
}

#pragma mark - zBar scanner

- (void)imagePickerController:(UIImagePickerController*)reader didFinishPickingMediaWithInfo:(NSDictionary*)info
{
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results) {
        // EXAMPLE: just grab the first barcode
        break;
    }
    
    NSString *isbnCode = symbol.data;
    if (isbnCode) {
        [[CustomActivityIndicator sharedActivityIndicator] startAsynchAnimating];
        [self startFetchingBookDetailFromDoubanWithIsbnCode:isbnCode];
    } else {
        [[CustomAlert sharedAlert] showAlertWithMessage:@"获取图书信息失败"];
    }
    
    [reader dismissViewControllerAnimated:YES completion:nil];
}

- (void)startFetchingBookDetailFromDoubanWithIsbnCode:(NSString *)isbnCode
{
    NSString *isbnUrlString = [NSString stringWithFormat:@"%@?apikey=%@", [kSearchIsbnCode stringByAppendingString:isbnCode], kAPIKey];
    NSString* encodedUrl = [isbnUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [JsonDataFetcher dataFromURL:[NSURL URLWithString:encodedUrl] withCompletion:^(NSData *jsonData) {
        [[CustomActivityIndicator sharedActivityIndicator] stopAsynchAnimating];
        
        if (jsonData != nil) {
            id object = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
            if (object) {
                Book *book = [DataConverter bookFromDoubanBookObject:object];
                [booksArray addObject:book];
                [[BookStore sharedStore] addBookToStore:book];
                [self loadTableViewData];
                [self.tableView reloadData];
            }
        } else {
            [[CustomAlert sharedAlert] showAlertWithMessage:@"请求失败"];
        }
    }];
}

#pragma mark - UITabelViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return booksArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Book *book = [booksArray objectAtIndex:indexPath.row];
    BookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bookTableViewCell"];
    cell.bookNameLabel.text = book.bookName;
    cell.bookAuthorsLabel.text = book.bookAuthors;
    [cell.bookImageView sd_setImageWithURL:[NSURL URLWithString:book.bookImageHref]];
    return cell;
}


@end
