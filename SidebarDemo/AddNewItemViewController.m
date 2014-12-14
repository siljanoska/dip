//
//  AddNewItemViewController.m
//  SidebarDemo
//
//  Created by Kireto on 8/21/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "AddNewItemViewController.h"
#import "Item.h"
#import "Category.h"
#import "AppViewController.h"
#import "ShowLocation.h"
#import "RecentEntriyViewController.h"
#import "MapViewController.h"
#import "MyLocationMapViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface AddNewItemViewController ()
@property (strong, nonatomic) NSString *objectID;

@end

@implementation AddNewItemViewController

-(NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context =nil;
    id delegate =[[UIApplication sharedApplication ]delegate];
    if([delegate performSelector:@selector(managedObjectContext)])
    {
        context = [delegate managedObjectContext];
    }
        return  context;
    
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    _labelName.text = _newobject.name;
    _imageView.image=[UIImage imageNamed:_newobject.imageName];
    _categoryname =_newobject.name;
    NSLog(@"Can't Save! %@  ",_categoryname);
    // Do any additional setup after loading the view.
    _enterAmontTextField.text =@"";
    _descriptioTextField.text=@"";
    _paymentMethod.text=@"";
    
    
}

-(void)locationName:(NSString *)name{
    _locationN = name;
    //_longitudeLabel.text= _locationName;
}


-(void)photoFromCamera:(UIImage *)image{
    _photoImageView.image =image;
}

-(void)photoFromCameraPath:(NSString *)path{
    _photoPath = path;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"camera"])
        {
        AppViewController *camera = segue.destinationViewController;
        camera.delegatePhotoFromCamera=self;
        camera.delegatePhotoFromCameraPath =self;
        }
    
    if ([segue.identifier isEqualToString:@"map"])
        {
        MyLocationMapViewController * map = segue.destinationViewController;
            NSLog(@"%@",map.description);
        }
    
    if ([segue.identifier isEqualToString:@"showLocation"])
     {
         ShowLocation *showloc =segue.destinationViewController;
         showloc.delegateLocationName=self;
     }
}



#pragma mark - UITextFieldDelegate
//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    
//    if (textField == self.enterAmontTextField) {
//       // self.enterAmont.keyboardType = UIKeyboardTypeNumberPad;
//        [self.descriptioTextField becomeFirstResponder];
//    }
//        else if (textField == self.descriptioTextField) {
//            
//            [self.paymentMethod becomeFirstResponder];
//        }
//        else if (textField == self.paymentMethod) {
//    
//            [self save :nil];
//    }
//    return YES;
//}

#pragma mark - Dismissing the keyboard
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if (![[touch view] isKindOfClass:[UITextField class]])
    {
        [self.view endEditing:YES];
    }
}


- (IBAction)pressSaveItemBtn:(id)sender {
   
    NSString *cancelTitle = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? @"Cancel" : nil;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Selec optios :"
                                                             delegate:self
                                                    cancelButtonTitle:cancelTitle
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:
                                  @"Save",
                                  @"Share on Facebook",
                                  @"Update status od FaceBook",
                                  @"Save to Camera Roll",
                                  nil];
    // actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // In this case the device is an iPad.
        [actionSheet showFromRect:[(UIButton *)sender frame] inView:self.view animated:YES];
    }
    else{
        // In this case the device is an iPhone/iPod Touch.
        [actionSheet showInView:self.view];
    }
    
   // actionSheet.tag = 100;
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
   // if (actionSheet.tag == 100) {
        if(buttonIndex == 0){
            if(!(([_enterAmontTextField.text isEqualToString:@""]) || ([_descriptioTextField.text isEqualToString:@""]) || ([_paymentMethod.text isEqualToString:@""])))
                    {
                        NSLog(@"Can't Save! %@ %@", _enterAmontTextField.text,_descriptioTextField.text);
                        NSManagedObjectContext *context= [self managedObjectContext];
                        //  if(_flag==1){
                        Item *newitem=[NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:context];
                        newitem.amount = [NSNumber numberWithInt:[self.enterAmontTextField.text intValue]] ;
                        newitem.descript = self.descriptioTextField.text;
                        newitem.paymentMethod = self.paymentMethod.text;
                        newitem.date = _datePicker.date;
                        newitem.time = _datePicker.date ;
                        newitem.photoPath =_photoPath;
                        newitem.location =_locationN;
                        NSLog(@"lokacijata e %@" , newitem.location);
                        [_newobject addItemsObject: newitem ];
                
                        // [_newobject addItemsIncomeObject:newitem];
                        NSError *error = nil;
                
                        // Save the object to persistent store
                        if (![context save:&error]) {
                            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                        }
                
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    else {
                        NSLog(@"mora da gi popolite site opcii" );
                        UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"error" message:@"Please field" delegate:nil cancelButtonTitle:@"Dissmiss" otherButtonTitles:nil];
                        [alertView show];
                    }
           //     }
    

    }
        else if(buttonIndex ==1){
            // Check if the Facebook app is installed and we can present the share dialog
            FBLinkShareParams *params = [[FBLinkShareParams alloc] init];
            params.link = [NSURL URLWithString:@"https://developers.facebook.com/docs/ios/share/"];
            
            // If the Facebook app is installed and we can present the share dialog
            if ([FBDialogs canPresentShareDialogWithParams:params]) {
                // Present the share dialog
                // Present share dialog
                [FBDialogs presentShareDialogWithLink:params.link
                                              handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                                  if(error) {
                                                      // An error occurred, we need to handle the error
                                                      // See: https://developers.facebook.com/docs/ios/errors
                                                      NSLog(@"Error publishing story: %@", error.description);
                                                  } else {
                                                      // Success
                                                      NSLog(@"result %@", results);
                                                  }
                                              }];
            } else {
                // Present the feed dialog
                // FALLBACK: publish just a link using the Feed dialog
                
                // Put together the dialog parameters
                NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                               @"Budget Control", @"name",
                                               //    @"Build great social apps and get more installs.", @"caption",
                                               @"Allow your users to share stories on Facebook from your app using the iOS SDK.", @"description",
                                               @"https://developers.facebook.com/docs/ios/share/", @"link",
                                               @"http://i.imgur.com/g3Qc1HN.png", @"picture",
                                               nil];
                
                // Show the feed dialog
                [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                                       parameters:params
                                                          handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                              if (error) {
                                                                  // An error occurred, we need to handle the error
                                                                  // See: https://developers.facebook.com/docs/ios/errors
                                                                  NSLog(@"Error publishing story: %@", error.description);
                                                              } else {
                                                                  if (result == FBWebDialogResultDialogNotCompleted) {
                                                                      // User canceled.
                                                                      NSLog(@"User cancelled.");
                                                                  } else {
                                                                      // Handle the publish feed callback
                                                                      NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                                                                      
                                                                      if (![urlParams valueForKey:@"post_id"]) {
                                                                          // User canceled.
                                                                          NSLog(@"User cancelled.");
                                                                          
                                                                      } else {
                                                                          // User clicked the Share button
                                                                          NSString *result = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
                                                                          NSLog(@"result %@", result);
                                                                      }
                                                                  }
                                                              }
                                                          }];
            }


        }
        else if(buttonIndex ==2){
            // Check if the Facebook app is installed and we can present the share dialog
            
            FBLinkShareParams *params = [[FBLinkShareParams alloc] init];
            params.link = [NSURL URLWithString:@"https://developers.facebook.com/docs/ios/share/"];
            
            // If the Facebook app is installed and we can present the share dialog
            if ([FBDialogs canPresentShareDialogWithParams:params]) {
                
                // Present share dialog
                [FBDialogs presentShareDialogWithLink:nil
                                              handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                                  if(error) {
                                                      // An error occurred, we need to handle the error
                                                      // See: https://developers.facebook.com/docs/ios/errors
                                                      NSLog(@"Error publishing story: %@", error.description);
                                                  } else {
                                                      // Success
                                                      NSLog(@"result %@", results);
                                                  }
                                              }];
                
                // If the Facebook app is NOT installed and we can't present the share dialog
            } else {
                // FALLBACK: publish just a link using the Feed dialog
                // Show the feed dialog
                [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                                       parameters:nil
                                                          handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                              if (error) {
                                                                  // An error occurred, we need to handle the error
                                                                  // See: https://developers.facebook.com/docs/ios/errors
                                                                  NSLog(@"Error publishing story: %@", error.description);
                                                              } else {
                                                                  if (result == FBWebDialogResultDialogNotCompleted) {
                                                                      // User cancelled.
                                                                      NSLog(@"User cancelled.");
                                                                  } else {
                                                                      // Handle the publish feed callback
                                                                      NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                                                                      
                                                                      if (![urlParams valueForKey:@"post_id"]) {
                                                                          // User cancelled.
                                                                          NSLog(@"User cancelled.");
                                                                          
                                                                      } else {
                                                                          // User clicked the Share button
                                                                          NSString *result = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
                                                                          NSLog(@"result %@", result);
                                                                      }
                                                                  }
                                                              }
                                                          }];
            }

            NSLog(@"Izbran e camera rool");

        }
        else if(buttonIndex==3){
//            
//            // If the Facebook app is installed and we can present the share dialog
//            FBLinkShareParams *params = [[FBLinkShareParams alloc] init];
//            params.link = [NSURL URLWithString:@"https://developers.facebook.com/docs/ios/share/"];
//
//            if ([FBDialogs canPresentShareDialogWithPhotos]) {
//                // Open the image picker and set this class as the delegate
//                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
//                [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
//                [imagePicker setDelegate:self];
//                [self presentViewController:imagePicker animated:YES completion:nil];
//            } else {
//                // The user doesn't have the Facebook for iOS app installed.  You
//                // may be able to use a fallback.
//            }
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            [imagePicker setDelegate:self];
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        }
    }


//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
//    
//    FBPhotoParams *params = [[FBPhotoParams alloc] init];
//    
//    // Note that params.photos can be an array of images.  In this example
//    // we only use a single image, wrapped in an array.
//    params.photos = @[img];
//    
//    [FBDialogs presentShareDialogWithPhotoParams:params
//                                     clientState:nil
//                                         handler:^(FBAppCall *call,
//                                                   NSDictionary *results,
//                                                   NSError *error) {
//                                             if (error) {
//                                                 NSLog(@"Error: %@",
//                                                       error.description);
//                                             } else {
//                                                 NSLog(@"Success!");
//                                             }
//                                         }];
//}
//
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    /// Package the image inside a dictionary
    NSArray* image = @[@{@"url": [info objectForKey:UIImagePickerControllerOriginalImage], @"user_generated": @"true"}];
    
    // Create an object
    id<FBGraphObject> object =
    [FBGraphObject openGraphObjectForPostWithType:@"fbogsamplesd:dish"
                                            title:@"Roasted pumpkin seeds"
                                            image:@"http://i.imgur.com/g3Qc1HN.png"
                                              url:@"http://example.com/roasted_pumpkin_seeds"
                                      description:@"Crunchy pumpkin seeds roasted in butter and lightly salted."];
    
    // Create an action
    id<FBOpenGraphAction> action = (id<FBOpenGraphAction>)[FBGraphObject graphObject];
    
    // Set image on the action
    [action setObject:image forKey:@"image"];
    
    // Link the object to the action
    [action setObject:object forKey:@"dish"];
    
    // Tag one or multiple users using the users' ids
    //[action setTags:@[<user-ids>]];
    
    // Tag a place using the place's id
    id<FBGraphPlace> place = (id<FBGraphPlace>)[FBGraphObject graphObject];
  //  [place setId:@"141887372509674"];
    [place setObjectID:@"141887372509674"]; // Facebook Seattle
// Facebook Seattle
    [action setPlace:place];
    
    // Dismiss the image picker off the screen
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // Check if the Facebook app is installed and we can present the share dialog
    FBOpenGraphActionParams *params = [[FBOpenGraphActionParams alloc] init];
    params.action = action;
    params.actionType = @"fbogsamplesd:eat";
    
    // If the Facebook app is installed and we can present the share dialog
    if([FBDialogs canPresentShareDialogWithOpenGraphActionParams:params]) {
        // Show the share dialog
        [FBDialogs presentShareDialogWithOpenGraphAction:action
                                              actionType:@"fbogsamplesd:eat"
                                     previewPropertyName:@"dish"
                                                 handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                                     if(error) {
                                                         // An error occurred, we need to handle the error
                                                         // See: https://developers.facebook.com/docs/ios/errors
                                                         NSLog(@"Error publishing story: %@", error.description);
                                                     } else {
                                                         // Success
                                                         NSLog(@"result %@", results);
                                                     }
                                                 }];
        
        // If the Facebook app is NOT installed and we can't present the share dialog
    } else {
        // FALLBACK: publish just a link using the Feed dialog
        
        // Put together the dialog parameters
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"Roasted pumpkin seeds", @"name",
                                       @"Healthy snack.", @"caption",
                                       @"Crunchy pumpkin seeds roasted in butter and lightly salted.", @"description",
                                       @"http://example.com/roasted_pumpkin_seeds", @"link",
                                       @"http://i.imgur.com/g3Qc1HN.png", @"picture",
                                       nil];
        
        // Show the feed dialog
        [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                               parameters:params
                                                  handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                      if (error) {
                                                          // An error occurred, we need to handle the error
                                                          // See: https://developers.facebook.com/docs/ios/errors
                                                          NSLog(@"Error publishing story: %@", error.description);
                                                      } else {
                                                          if (result == FBWebDialogResultDialogNotCompleted) {
                                                              // User cancelled.
                                                              NSLog(@"User cancelled.");
                                                          } else {
                                                              // Handle the publish feed callback
                                                              NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                                                              
                                                              if (![urlParams valueForKey:@"post_id"]) {
                                                                  // User cancelled.
                                                                  NSLog(@"User cancelled.");
                                                                  
                                                              } else {
                                                                  // User clicked the Share button
                                                                  NSString *result = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
                                                                  NSLog(@"result %@", result);
                                                              }
                                                          }
                                                      }
                                                  }];
        
    }
    
}

//
//    if(!(([_enterAmontTextField.text isEqualToString:@""]) || ([_descriptioTextField.text isEqualToString:@""]) || ([_paymentMethod.text isEqualToString:@""])))
//    {
//        NSLog(@"Can't Save! %@ %@", _enterAmontTextField.text,_descriptioTextField.text);
//        NSManagedObjectContext *context= [self managedObjectContext];
//        //  if(_flag==1){
//        Item *newitem=[NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:context];
//        newitem.amount = [NSNumber numberWithInt:[self.enterAmontTextField.text intValue]] ;
//        newitem.descript = self.descriptioTextField.text;
//        newitem.paymentMethod = self.paymentMethod.text;
//        newitem.date = _datePicker.date;
//        newitem.time = _datePicker.date ;
//        newitem.photoPath =_photoPath;
//        newitem.location =_locationN;
//        NSLog(@"lokacijata e %@" , newitem.location);
//        [_newobject addItemsObject: newitem ];
//        
//        // [_newobject addItemsIncomeObject:newitem];
//        NSError *error = nil;
//        
//        // Save the object to persistent store
//        if (![context save:&error]) {
//            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
//        }
//        
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//    else {
//        NSLog(@"mora da gi popolite site opcii" );
//        UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"error" message:@"Please field" delegate:nil cancelButtonTitle:@"Dissmiss" otherButtonTitles:nil];
//        [alertView show];
//    }
//}


//------------------Sharing a link using the share dialog------------------
- (IBAction)shareLinkWithShareDialog:(id)sender {
    // Check if the Facebook app is installed and we can present the share dialog
    FBLinkShareParams *params = [[FBLinkShareParams alloc] init];
    params.link = [NSURL URLWithString:@"https://developers.facebook.com/docs/ios/share/"];
    
    // If the Facebook app is installed and we can present the share dialog
    if ([FBDialogs canPresentShareDialogWithParams:params]) {
        // Present the share dialog
        // Present share dialog
        [FBDialogs presentShareDialogWithLink:params.link
                                      handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                          if(error) {
                                              // An error occurred, we need to handle the error
                                              // See: https://developers.facebook.com/docs/ios/errors
                                              NSLog(@"Error publishing story: %@", error.description);
                                          } else {
                                              // Success
                                              NSLog(@"result %@", results);
                                          }
                                      }];
    } else {
        // Present the feed dialog
        // FALLBACK: publish just a link using the Feed dialog
        
        // Put together the dialog parameters
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"Budget Control", @"name",
                                   //    @"Build great social apps and get more installs.", @"caption",
                                       @"Allow your users to share stories on Facebook from your app using the iOS SDK.", @"description",
                                       @"https://developers.facebook.com/docs/ios/share/", @"link",
                                       @"http://i.imgur.com/g3Qc1HN.png", @"picture",
                                       nil];
        
        // Show the feed dialog
        [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                               parameters:params
                                                  handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                      if (error) {
                                                          // An error occurred, we need to handle the error
                                                          // See: https://developers.facebook.com/docs/ios/errors
                                                          NSLog(@"Error publishing story: %@", error.description);
                                                      } else {
                                                          if (result == FBWebDialogResultDialogNotCompleted) {
                                                              // User canceled.
                                                              NSLog(@"User cancelled.");
                                                          } else {
                                                              // Handle the publish feed callback
                                                              NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                                                              
                                                              if (![urlParams valueForKey:@"post_id"]) {
                                                                  // User canceled.
                                                                  NSLog(@"User cancelled.");
                                                                  
                                                              } else {
                                                                  // User clicked the Share button
                                                                  NSString *result = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
                                                                  NSLog(@"result %@", result);
                                                              }
                                                          }
                                                      }
                                                  }];
    }
}


- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}



- (IBAction)shareUpdateWithShareDialog:(id)sender {
    
    // Check if the Facebook app is installed and we can present the share dialog
    
    FBLinkShareParams *params = [[FBLinkShareParams alloc] init];
    params.link = [NSURL URLWithString:@"https://developers.facebook.com/docs/ios/share/"];
    
    // If the Facebook app is installed and we can present the share dialog
    if ([FBDialogs canPresentShareDialogWithParams:params]) {
        
        // Present share dialog
        [FBDialogs presentShareDialogWithLink:nil
                                      handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                          if(error) {
                                              // An error occurred, we need to handle the error
                                              // See: https://developers.facebook.com/docs/ios/errors
                                              NSLog(@"Error publishing story: %@", error.description);
                                          } else {
                                              // Success
                                              NSLog(@"result %@", results);
                                          }
                                      }];
        
        // If the Facebook app is NOT installed and we can't present the share dialog
    } else {
        // FALLBACK: publish just a link using the Feed dialog
        // Show the feed dialog
        [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                               parameters:nil
                                                  handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                      if (error) {
                                                          // An error occurred, we need to handle the error
                                                          // See: https://developers.facebook.com/docs/ios/errors
                                                          NSLog(@"Error publishing story: %@", error.description);
                                                      } else {
                                                          if (result == FBWebDialogResultDialogNotCompleted) {
                                                              // User cancelled.
                                                              NSLog(@"User cancelled.");
                                                          } else {
                                                              // Handle the publish feed callback
                                                              NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                                                              
                                                              if (![urlParams valueForKey:@"post_id"]) {
                                                                  // User cancelled.
                                                                  NSLog(@"User cancelled.");
                                                                  
                                                              } else {
                                                                  // User clicked the Share button
                                                                  NSString *result = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
                                                                  NSLog(@"result %@", result);
                                                              }
                                                          }
                                                      }
                                                  }];
    }

}

- (IBAction)paymentMethodChange:(id)sender {
    switch (self.segmentControll.selectedSegmentIndex)
    {
        case 0:
            self.paymentMethod.text = @"Card";
            break;
        case 1:
            self.paymentMethod.text = @"Cash";
            break;
        default: 
            break; 
    }
}
@end
