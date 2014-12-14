//
//  AddMemberController.h
//  SidebarDemo
//
//  Created by TheMac on 11/24/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Profil;

@interface AddMemberController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *memberNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailMemberTextField;
- (IBAction)pressSaveBtn:(id)sender;
@property (strong, nonatomic) Profil *profil;
@end
