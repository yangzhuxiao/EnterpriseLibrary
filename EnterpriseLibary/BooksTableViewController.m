//
//  AddBookViewController.m
//  EnterpriseLibary
//
//  Created by Yang Xiaozhu on 1/25/15.
//  Copyright (c) 2015 Xiaozhu-Jianing. All rights reserved.
//

#import "BooksTableViewController.h"

@interface BooksTableViewController ()
{
    UIView *searchBarWrapperView;
    UISearchController *searchController;
}
@end

@implementation BooksTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)addBook:(id)sender {
    UIActionSheet *selectAddMethod = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"扫描ISBN码",@"搜索书名、作者", nil];
    [selectAddMethod showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSLog(@"scanning....");
        return;
    }
    if (buttonIndex == 1) {
        NSLog(@"searching....");
        return;
    }
}
@end
