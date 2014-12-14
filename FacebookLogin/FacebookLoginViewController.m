//
//  FacebookLoginViewController.m
//  SidebarDemo
//
//  Created by TheMac on 11/16/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "FacebookLoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "SWRevealViewController.h"
#import "Profil.h"
#import "AppDelegate.h"
#import "Globals.h"
@interface FacebookLoginViewController ()
@property NSArray *profilList;
@property NSArray * objectProfils ;

@end

@implementation FacebookLoginViewController


-(NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context =nil;
    id delegate =[[UIApplication sharedApplication ]delegate];
    if([delegate performSelector:@selector(managedObjectContext)]){
        context = [delegate managedObjectContext];
    }
    return  context;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginView.readPermissions = @[@"public_profile", @"email", @"user_friends"];
   // NSArray *lista = self.loginView.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    
    
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest1 = [[NSFetchRequest alloc] initWithEntityName:@"Profil"];
    _objectProfils = [[managedObjectContext executeFetchRequest:fetchRequest1 error:nil]mutableCopy];
    NSLog(@"objectProfil list e %lu",(unsigned long)[_objectProfils count]);
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
   NSManagedObjectContext *managedObjectContext = [self managedObjectContext];

    self.profilePictureView.profileID = user.objectID;
    self.nameLabel.text = user.name;
    
    [self.nameLabel sizeToFit];
    [Globals saveLoginName:user.name];

    if([_objectProfils count]){
        BOOL exsiste = NO;
        for (Profil *p in _objectProfils){
            if([p.nameP isEqualToString:[Globals loadLoginNameValue]]){
                [Globals saveCurrentProfil:p];
                exsiste=YES;
                break;
            }
        }
        if(!exsiste){
            
        _profil= [NSEntityDescription insertNewObjectForEntityForName:@"Profil" inManagedObjectContext:managedObjectContext];
        _profil.nameP = [Globals loadLoginNameValue];
        [Globals saveCurrentProfil:_profil];
        [Globals saveLoginName:user.name];

        }
    }
    else {
        
    _profil= [NSEntityDescription insertNewObjectForEntityForName:@"Profil" inManagedObjectContext:managedObjectContext];
    _profil.nameP = [Globals loadLoginNameValue];
        [Globals saveCurrentProfil:_profil];
        [Globals saveLoginName:user.name];


        }

}


- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    self.statusLabel.text = @"You're logged in as";
    UIBarButtonItem *menu =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self.revealViewController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem = menu;
    // name=user.name;
   [self.statusLabel sizeToFit];
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    self.profilePictureView.profileID = nil;
    self.nameLabel.text = @"";
    self.statusLabel.text= @"You're not logged in!";
   [self.statusLabel sizeToFit];
    UIBarButtonItem *menu =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self.revealViewController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem = menu;
    menu.enabled =NO ;
    

    
}

// Handle possible errors that can occur during login
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    
    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures that happen outside of the app
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}



/*
 
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
