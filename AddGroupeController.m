//
//  AddGroupeController.m
//  SidebarDemo
//
//  Created by TheMac on 11/19/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "AddGroupeController.h"
#import "Groupe.h"
#import "Profil.h"
#import "AppDelegate.h"
#import "Globals.h"
#import "MembersViewController.h"
#import "Member.h"
#import "IBActionSheet.h"
#import "Debts.h"
@interface AddGroupeController ()
@property (strong) NSMutableArray *objectMember;
@property (strong) NSString *string1;
@property (strong) NSArray *groupeMember;

@end

@implementation AddGroupeController

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _currencyBtn.selected = NO;
    _objectMember = [[NSMutableArray alloc] init];


}
-(void)viewDidAppear:(BOOL)animated{
   
    NSLog(@"brojt na elemnti vo objectGroupe e%i",_objectMember.count);
    if(_groupeMember.count > 0){
   NSString *string1 =@" ";
    int i= 0;
    for (Member *mem in _groupeMember) {
        string1 = [string1 stringByAppendingString:mem.name];
        if(i<[_groupeMember count])
        {
        string1 = [string1 stringByAppendingString:@","];
        i++;
        }
        else{
            string1 = [string1 stringByAppendingString:@""];

        }
    NSLog(@"stringot e %@", string1);
}
    _memberTextField.text = string1;
    }
  
        

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if (![[touch view] isKindOfClass:[UITextField class]])
    {
        [self.view endEditing:YES];
    }
}

-(void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
    if ([segue.identifier isEqualToString: @"listMembers"])
    {
        MembersViewController *membervc = segue.destinationViewController;
        membervc.delegateArrayOfMembersInGroupe=self;

    }
   
    
}



- (IBAction)pressCurrencyBtn:(id)sender {
  
    NSString *cancelTitle = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? @"Cancel" : nil;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Currency pick:"
                                                             delegate:self
                                                    cancelButtonTitle:cancelTitle
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"EUR" , @"USD", @"GBR", @"MKD",nil];
    
    // actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // In this case the device is an iPad.
        [actionSheet showFromRect:[(UIButton *)sender frame] inView:self.view animated:YES];
    }
    else{
        // In this case the device is an iPhone/iPod Touch.
        [actionSheet showInView:self.view];
    }
    
    actionSheet.tag = 100;
    
}


//    [[[actionSheet valueForKey:@"_buttons"] objectAtIndex:0] setImage:[UIImage imageNamed:@"097.png"] forState:UIControlStateNormal];
//       [[[actionSheet valueForKey:@"_buttons"] objectAtIndex:1] setImage:[UIImage imageNamed:@"097.png"] forState:UIControlStateNormal];
//       [[[actionSheet valueForKey:@"_buttons"] objectAtIndex:2] setImage:[UIImage imageNamed:@"097.png"] forState:UIControlStateNormal];
//    for (UIView *subview in actionSheet.subviews) {
//        if ([subview isKindOfClass:[UIButton class]]) {
//            UIButton *button = (UIButton *)subview;
//            [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//        }
//    }
//   _actionSheet = [[IBActionSheet alloc] initWithTitle:@"Currency pick:"
//                                                                                               delegate:self
//                                                                                      cancelButtonTitle:cancelTitle
//                                                                                 destructiveButtonTitle:nil
//                                                                                      otherButtonTitles:@"EUR" , @"USD", @"GBR", @"MKD",nil];
//
//    
//    
//     [self.actionSheet setButtonBackgroundColor:[UIColor colorWithRed:0.258 green:1.000 blue:0.499 alpha:1.000]];
//     [self.actionSheet setButtonTextColor:[UIColor whiteColor]];
//     [self.actionSheet setTitleBackgroundColor:[UIColor orangeColor]];
//     [self.actionSheet setTitleTextColor:[UIColor blackColor]];
//     [self.actionSheet setTitleFont:[UIFont fontWithName:@"Noteworthy-Bold" size:10]];
//     
//     [self.actionSheet setButtonTextColor:[UIColor orangeColor] forButtonAtIndex:0];
//     [self.actionSheet setButtonBackgroundColor:[UIColor purpleColor] forButtonAtIndex:0];
//     [self.actionSheet setFont:[UIFont fontWithName:@"HelveticaNeue-Italic" size:22] forButtonAtIndex:0];
//     
//    [self.actionSheet showInView:self.view];
//     }

//
//-(void)actionSheet:(IBActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (actionSheet.tag == 100) {
//        _currencyTextField.text = [actionSheet buttonTitleAtIndex:buttonIndex];
//    }
//  }


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 100) {
        _currencyTextField.text = [actionSheet buttonTitleAtIndex:buttonIndex];
    }
  }

-(void)willPresentActionSheet:(UIActionSheet *)actionSheet{
    
    UIImageView* df = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"097.png"]];
    df.frame=CGRectMake(0, 0, 320, 44);
    //scale image aspect to fit image view
    //df.contentMode = UIViewContentModeScaleAspectFit;
    //change width of frame
    //df.frame = CGRectMake(0, 0, 320, 40);
    df.backgroundColor =[UIColor redColor];
    [actionSheet sendSubviewToBack:df];

    [actionSheet addSubview:df];

}


- (IBAction)pressSaveBtn:(id)sender {

    if(!(([_groupeNameTextField.text isEqualToString:@""]) || ([_memberTextField.text isEqualToString:@""]) || ([_currencyTextField.text isEqualToString:@""])))
    {
    
        NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
        Groupe *groupe = [NSEntityDescription insertNewObjectForEntityForName:@"Groupe" inManagedObjectContext:managedObjectContext];
        [_profil addProfillGroupsObject:groupe];
        //pravam debts i toa i go ddodavam na grupata
       


        groupe.nameGroupe = _groupeNameTextField.text;
        groupe.currency =_currencyTextField.text;
        
        for(Member *mem in _groupeMember){
        
            [groupe addGroupeMembersObject:mem];
        }
        NSLog(@"_profil.nameP e%@",_profil.nameP);
        NSLog(@"bgroupe.nameGroupe e %@",groupe.nameGroupe);
        NSLog(@"_groupeMember.counte%lu",(unsigned long)_groupeMember.count);
        NSLog(@"groupe.groupeMembers.count  e%lu",(unsigned long)groupe.groupeMembers.count);
        NSLog(@"groupe.groupeMembers.descriptionta  e %@",groupe.groupeMembers.description);
        NSLog(@"_profil.description %@",_profil.description);

    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    else {
   
    UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please fill all fields !" delegate:nil cancelButtonTitle:@"Dissmiss" otherButtonTitles:nil];
    [alertView show];
}

}

-(void )arrayOfMembersInGroupe:(NSArray *)array{
    
    _objectMember =[array mutableCopy];

    _groupeMember=array;
    
    NSLog(@"brojt na elemnti vo objectGroupe e%lu",(unsigned long)_objectMember.count);
    NSLog(@"brojt na elemnti vo _grupeMember  e%lu",(unsigned long)_groupeMember.count);

}
@end
