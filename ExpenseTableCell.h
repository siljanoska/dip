//
//  ExpenseTableCell.h
//  SidebarDemo
//
//  Created by TheMac on 12/4/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpenseTableCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *whoPaidLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *forpaidLabel;

@end
