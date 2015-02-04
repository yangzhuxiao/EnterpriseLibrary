//
//  AdminBookDetailTableViewController.h
//  EnterpriseLibary
//
//  Created by Yang Xiaozhu on 1/26/15.
//  Copyright (c) 2015 Xiaozhu-Jianing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminBookDetailTableViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UIImageView *bookImageView;
@property (strong, nonatomic) IBOutlet UILabel *bookNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *bookAuthorsLabel;
@property (strong, nonatomic) IBOutlet UILabel *bookPublisherLabel;
@property (strong, nonatomic) IBOutlet UILabel *bookPublishDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *bookPriceLabel;

@property (strong, nonatomic) IBOutlet UITextField *bookTotalCountTextField;
- (IBAction)addBookButtonClicked:(id)sender;
- (IBAction)deleteBookButtonClicked:(id)sender;

@end
