//
//  AddGroupeViewController.h
//  SidebarDemo
//
//  Created by TheMac on 11/13/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownListView.h"

@class Profil;
@class CategoryPom;
@class Groupe;

@interface AddGroupeViewController : UIViewController <UIActionSheetDelegate ,kDropDownListViewDelegate>{
    NSArray *arryList;
    DropDownListView * Dropobj;
    NSString *pom;
}

@property (weak, nonatomic) IBOutlet UIButton *groupeDebtsBtn;
@property (weak, nonatomic) IBOutlet UIButton *paymentBtn;
@property (weak, nonatomic) IBOutlet UIButton *debtsBtn;
@property ( nonatomic)  UIControlState *state;
@property (weak, nonatomic) IBOutlet UIButton *selectGroup;
- (IBAction)pressSelectGroup:(id)sender;

- (IBAction)pressGroupeBtn:(id)sender;
- (IBAction)pressPaymentBtn:(id)sender;
- (IBAction)pressDebtsBtn:(id)sender;
- (IBAction)pressMembersBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *membersBtn;

@property (strong, nonatomic)CategoryPom *categorypom;
@property (strong, nonatomic)Profil *profil;
@property (strong, nonatomic)Groupe *grExpense;
@property (strong, nonatomic)Groupe *selectedGroup;


@property (weak, nonatomic) IBOutlet UITableView *memberTableView;
@property (weak, nonatomic) IBOutlet UITableView *expenseTableView;
@property (weak, nonatomic) IBOutlet UITableView *groupesTableView;
@property (weak, nonatomic) IBOutlet UITableView *debtsTableView;

@property (weak, nonatomic) IBOutlet UIView *membersView;
@property (weak, nonatomic) IBOutlet UIView *paymentView;
@property (weak, nonatomic) IBOutlet UIView *debtsView;
@property (weak, nonatomic) IBOutlet UIView *groupeDebtsView;
@end
