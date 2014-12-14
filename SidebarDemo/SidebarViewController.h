//
//  SidebarViewController.h
//  SidebarDemo
//
//  Created by Simon on 29/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocol.h"
@class FBLoginView;
@interface SidebarViewController : UITableViewController{
    BOOL isExpanding;
    NSString *profilName;
}
@property (weak, nonatomic) IBOutlet FBLoginView *loginView;
@property (weak, nonatomic) IBOutlet UIView *profilView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak , nonatomic) IBOutlet NSString *labelName;
@end
