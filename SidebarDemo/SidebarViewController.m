//
//  SidebarViewController.m
//  SidebarDemo
//
//  Created by Simon on 29/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "SidebarViewController.h"
#import "SWRevealViewController.h"
#import "PhotoViewController.h"
#import "Protocol.h"
#import "FacebookLoginViewController.h"
#import "Globals.h"
//#import "ReportDayCell.m"
//#import "DTCustomColoredAccessory.h"
@interface SidebarViewController ()

@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, strong) NSArray *menuItemsImages;
//@property (nonatomic,strong) ProfilViewController *profilController;
//@property (nonatomic , weak) UIView *profilList;
@end

@implementation SidebarViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    self.view.backgroundColor = [UIColor colorWithRed:0 green:18 blue:255 alpha:1.0f];
  //  self.view.backgroundColor = [UIColor whiteColor];

   self.tableView.backgroundColor = [UIColor colorWithWhite:0.60 alpha:1.0];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    //  self.tableView.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
  //  self.tableView.separatorColor = [UIColor colorWithWhite:0.15f alpha:0.2f];
    _menuItems = @[@"Home", @"Recent entries", @"Report",@"Groupe Debts"];
    _menuItemsImages =@[@"home1.png",@"recententries1.png",@"report1.png",@"groupeDebts.png"];

}
-(void)viewDidAppear:(BOOL)animated{

   
    
}
- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
    // Set the title of navigation bar by using the menu items
  //  NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
  //  UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    //destViewController.title = [[_menuItems objectAtIndex:indexPath.row] capitalizedString];
    
 
    
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] ) {
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
       
      
        
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers: @[dvc] animated: NO ];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        };
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0){
//        if ([self tableView:tableView canCollapseSection:0])
//        {
//            if ([expandedSections containsIndex:section])
//            {
        
                return 1;
            }
    else{
    
        return 4;//[self.menuItems count];
    }
}

//-(void)nameProfil:(NSString *)name{
//             // UITableViewCell *cell=[tableView cellForRowAtIndexPath:0];
//
//    _labelName= name;
//}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0) {
        return @"Profil ";
    }
    
    else if(section==1)
    {
    return @"Financial Report";
    }
    return @"";
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell ;
         if(indexPath.section == 0) {
          
    NSString *CellIdentifier = @"profil";
          
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
          
    if(!cell){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
          //   cell.backgroundColor = [UIColor colorWithRed:46 green:66 blue:256 alpha:1.0f];

          //cell.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
           //  cell.backgroundColor = [UIColor colorWithRed:0 green:122 blue:255 alpha:1.0f];
             cell.textLabel.textColor=[UIColor blueColor];

            // cell.textLabel.textColor=[UIColor whiteColor];
          profilName = [Globals loadLoginNameValue];
     //        cell.imageView.image=[UIImage imageNamed:@"profil1"];
          NSLog(@"imeto na profilot e %@",profilName);
          cell.textLabel.text = profilName;
             [cell sizeToFit];
}
    else {
        
        NSString *CellIdentifier = [self.menuItems objectAtIndex:indexPath.row];
       cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
   
        if(!cell){
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
      }
        cell.textLabel.text = [[_menuItems objectAtIndex:indexPath.row] capitalizedString];
        cell.textLabel.textColor=[UIColor blueColor];

      //  cell.backgroundColor = [UIColor colorWithRed:46 green:66 blue:256 alpha:1.0f];

          //  cell.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
      //   cell.textLabel.textColor=[UIColor whiteColor];
        cell.imageView.image = [UIImage imageNamed:[self.menuItemsImages objectAtIndex:indexPath.row]];
    }
    return cell;
 }



@end
