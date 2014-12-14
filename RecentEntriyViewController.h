//
//  RecentEntriyViewController.h
//  SidebarDemo
//
//  Created by Kireto on 9/1/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Category.h"
#import "AddNewItemViewController.h"

@class Profil;
@class CategoryPom;

@interface RecentEntriyViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *_sidebarButton;
@property (weak , nonatomic) IBOutlet UITableView *tableView;
@property (strong , nonatomic) Category *newobject;
@property (strong, nonatomic) Profil * profil;
@property (strong, nonatomic) CategoryPom * categorypom;
@property (weak, nonatomic) IBOutlet UIButton *expenseBtn;
@property (weak, nonatomic) IBOutlet UIButton *incomeBtn;
- (IBAction)pressExpenseBtn:(id)sender;
- (IBAction)pressIncomeBtn:(id)sender;

@end
