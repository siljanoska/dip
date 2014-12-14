//
//  FacebookLoginViewController.h
//  SidebarDemo
//
//  Created by TheMac on 11/16/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "Protocol.h"
@class Profil;

@interface FacebookLoginViewController : UIViewController <FBLoginViewDelegate>{
    NSString *name;
}
@property (weak, nonatomic) IBOutlet FBLoginView *loginView;
@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePictureView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) Profil *profil;
@end
