//
//  AddExpenseViewController.h
//  SidebarDemo
//
//  Created by TheMac on 11/20/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//
#import "Protocol.h"
#import <UIKit/UIKit.h>
#import "DropDownListView.h"
@class  Groupe;
@class  Expense;
@interface AddExpenseViewController : UIViewController <UITextFieldDelegate ,kDropDownListViewDelegate>{
    NSArray *arryList;
    DropDownListView * Dropobj;
    
}
- (IBAction)pressSaveBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextField *whopaidTextField;
@property (strong, nonatomic) IBOutlet UITextField *textFieldQuanty;
@property (strong, nonatomic) IBOutlet NSString *nameProfil;
@property (weak, nonatomic) IBOutlet UITextField *nameOfGropueTextField;
@property (weak, nonatomic) IBOutlet UITextField *membersOfGroupe;
- (void)textFieldDidEndEditing:(UITextField *)textField;
@property (strong, nonatomic) Groupe *groupe;
- (IBAction)pressWhoPaidButton:(id)sender;
@property (strong, nonatomic) Expense *expense;
@property (weak, nonatomic) IBOutlet UIButton *whopaidButton;
@end
