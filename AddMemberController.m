//
//  AddMemberController.m
//  SidebarDemo
//
//  Created by TheMac on 11/24/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "AddMemberController.h"
#import "Member.h"
#import "Profil.h"
#import "Debts.h"
@interface AddMemberController ()

@end

@implementation AddMemberController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)pressSaveBtn:(id)sender {
    
    if(!(([_memberNameTextField.text isEqualToString:@""]) || ([_emailMemberTextField.text isEqualToString:@""])))
    {
        NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
        
        Member *member = [NSEntityDescription insertNewObjectForEntityForName:@"Member" inManagedObjectContext:managedObjectContext];
        
        
        member.name = _memberNameTextField.text;
        member.email =_emailMemberTextField.text;
        [_profil addProfilMemberObject:member];
        
        //pravam deb i toj i go dodavam na member
        Debts *deb = [NSEntityDescription insertNewObjectForEntityForName:@"Debts" inManagedObjectContext:managedObjectContext];
        deb.debtsMember =member;
        
        NSError *error = nil;
        if (![managedObjectContext save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    else {
        
        NSLog(@"mora da gi popolite site opcii" );
        UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"error" message:@"Please field all!!" delegate:nil cancelButtonTitle:@"Dissmiss" otherButtonTitles:nil];
        [alertView show];
    }

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if (![[touch view] isKindOfClass:[UITextField class]])
    {
        [self.view endEditing:YES];
    }
}
@end
