//
//  AddGroupeController.h
//  SidebarDemo
//
//  Created by TheMac on 11/19/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocol.h"
@class Profil;
@class Groupe;
@class IBActionSheet;
@interface AddGroupeController : UIViewController <UIActionSheetDelegate, ArrayOfMembersInGroupeProtocol>
//@property (strong, nonatomic) NSArray *currencyArray;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UITextField *groupeNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *currencyTextField;
@property (weak, nonatomic) IBOutlet UITextField *memberTextField;
@property (strong, nonatomic) Profil *profil;

@property(strong,nonatomic)IBOutlet IBActionSheet *actionSheet;
//@property (strong, nonatomic) Groupe *groupe;
- (IBAction)pressCurrencyBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *currencyBtn;
- (IBAction)pressSaveBtn:(id)sender;
@end
