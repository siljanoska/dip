//
//  AppViewController.m
//  SidebarDemo
//
//  Created by Kireto on 9/22/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "AppViewController.h"
#import "Item.h"
@interface AppViewController ()

@end

@implementation AppViewController

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
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context =nil;
    id delegate =[[UIApplication sharedApplication ]delegate];
    if([delegate performSelector:@selector(managedObjectContext)])
    {
        
        context = [delegate managedObjectContext];
        
    }
    
    
    return  context;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *choseImage= info[UIImagePickerControllerEditedImage];
    
//    UIImage *chosePhoto;
//    chosePhoto =(UIImage*)[info objectForKey:UIImagePickerControllerEditedImage];
    self.imageView.image =choseImage;
    [self.delegatePhotoFromCamera photoFromCamera:choseImage];
    UIImageWriteToSavedPhotosAlbum(choseImage, nil, nil, nil);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString *documentsDirectory =[paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      @"test.png" ];
    NSData* data = UIImagePNGRepresentation(choseImage);
    [data writeToFile:path atomically:YES];
    NSLog(@"%@", path);
    [self.delegatePhotoFromCameraPath photoFromCameraPath:path];
    
    
     _newitem.photoPath = path;
   // NSLog("%@",_newitem);
  /*  NSManagedObjectContext *context= [self managedObjectContext];
    Item *newitem=[NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:context];
    newitem.photoPath = path;
    */
    
    [picker dismissViewControllerAnimated:YES completion:NULL];

}



//-(void)imageSavedToPhotoAlbum:(UIImage *)image didFins
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (IBAction)takePhoto:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate =self;
    picker.allowsEditing =YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)selectPhoto:(id)sender {
    UIImagePickerController *picker2 = [[UIImagePickerController alloc] init];
    picker2.delegate =self;
    picker2.allowsEditing =YES;
    picker2.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker2 animated:YES completion:NULL];
}
- (IBAction)savePhoto:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
   [self.delegatePhotoFromCamera photoFromCamera:self.imageView.image];
}
@end
