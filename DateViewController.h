//
//  DateViewController.h
//  SidebarDemo
//
//  Created by Kireto on 9/17/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocol.h"
@interface DateViewController : UIViewController
@property (weak , nonatomic ) id <DateProtocol> delegate;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *done;
@property (weak , nonatomic) NSString *date;
- (IBAction)done:(id)sender;

@end
