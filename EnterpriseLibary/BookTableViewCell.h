//
//  BookTableViewCell.h
//  EnterpriseLibary
//
//  Created by Yang Xiaozhu on 1/25/15.
//  Copyright (c) 2015 Xiaozhu-Jianing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *bookImageView;
@property (strong, nonatomic) IBOutlet UILabel *bookAuthorsLabel;
@property (strong, nonatomic) IBOutlet UILabel *bookNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *bookCountLabel;

@end
