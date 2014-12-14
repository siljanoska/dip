//
//  AddNewItemViewController.h
//  SidebarDemo
//
//  Created by Kireto on 8/21/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Category.h"
#import "RecentEntriyViewController.h"
#import "Protocol.h"
@interface AddNewItemViewController : UIViewController <PhotoFromCameraProtocol ,UIImagePickerControllerDelegate ,PhotoFromCameraPathProtocol,LocationNameProtocol,UIActionSheetDelegate, UINavigationControllerDelegate >
  
- (IBAction)pressSaveItemBtn:(id)sender;
- (IBAction)shareLinkWithShareDialog:(id)sender;
- (IBAction)shareUpdateWithShareDialog:(id)sender;

- (IBAction)paymentMethodChange:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *shareUpdateWithShareDialog;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControll;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *amountView;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UITextField *enterAmontTextField;
@property (assign, nonatomic)  int flag;
@property (weak, nonatomic) IBOutlet UITextField *descriptioTextField;
@property (weak, nonatomic) IBOutlet UITextField *paymentMethod;
@property (weak, nonatomic) IBOutlet UIView *descriptionView;
@property (weak, nonatomic) IBOutlet UIView *paymentMethodView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong , nonatomic) Category *newobject;
@property (strong , nonatomic) NSString * photoPath;
@property (strong , nonatomic) NSString *locationN;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (strong, nonatomic) NSString *categoryname;

@end
