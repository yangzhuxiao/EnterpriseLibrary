//
//  AddBookViewController.h
//  EnterpriseLibary
//
//  Created by Yang Xiaozhu on 1/25/15.
//  Copyright (c) 2015 Xiaozhu-Jianing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LibzBar/Headers/ZBarSDK/ZBarSDK.h"

@interface BooksTableViewController : UITableViewController <UIActionSheetDelegate, ZBarReaderDelegate>
- (IBAction)addBook:(id)sender;

@end
