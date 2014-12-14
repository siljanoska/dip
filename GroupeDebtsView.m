//
//  GroupeDebtsView.m
//  SidebarDemo
//
//  Created by TheMac on 11/14/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "GroupeDebtsView.h"
#import "AddGroupeController.h"
#import "AddGroupeViewController.h"

#import "AppDelegate.h"

@implementation GroupeDebtsView



-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [[NSBundle mainBundle ] loadNibNamed:@"GroupeDebtsView" owner:self options:nil];
        [self addSubview:self.view];
}
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return [_groupsArray  count];
 
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor colorWithRed:109.0/255.0 green:120.0/255.0 blue:131.0/255.0 alpha:1.0];
        cell.textLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:17.0];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = @"simona";
    
        return cell;
}


- (IBAction)pressAddGroupeBtn:(id)sender {
//
// //   UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
////    AddGroupeController *viewController = (AddGroupeController *)[storyboard instantiateViewControllerWithIdentifier:@"YourViewControllerIdentifier"];
////    [self.navigationcontroller pushViewController:viewController animated:YES];
//   // ViewController *objview = [[ViewController alloc]init]; [appDelegate.navControl pushViewController:objview animated:YES];
//  //  UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
//    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
//   // BBCounterySettingsViewController *controller = (BBCounterySettingsViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"CountrySettings"];
// //       [addGroupe presentationController]
////    [navigationController pushViewController:addGroupe animated:NO];
}
@end
