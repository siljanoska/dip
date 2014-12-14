//
//  AppViewController.h
//  SidebarDemo
//
//  Created by Kireto on 9/22/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocol.h"
#import "Item.h"
@interface AppViewController : UIViewController <UIImagePickerControllerDelegate , UINavigationControllerDelegate >

- (IBAction)savePhoto:(id)sender;
- (IBAction)takePhoto:(id)sender;
- (IBAction)selectPhoto:(id)sender;
@property (weak , nonatomic) id <PhotoFromCameraProtocol> delegatePhotoFromCamera;
@property (weak, nonatomic) id <PhotoFromCameraPathProtocol> delegatePhotoFromCameraPath;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) Item *newitem;
@end
