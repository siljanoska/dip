//
//  MembersViewController.h
//  SidebarDemo
//
//  Created by TheMac on 11/24/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocol.h"
@class Groupe;
@class Profil;

@interface MembersViewController : UIViewController
@property (nonatomic , weak) id<ArrayOfMembersInGroupeProtocol>delegateArrayOfMembersInGroupe;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) Groupe *groupeM;
@property (nonatomic, strong) Profil *profil;


- (IBAction)pressSaveBtn:(id)sender;

@end
