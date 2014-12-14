//
//  TabBarViewController.m
//  SidebarDemo
//
//  Created by TheMac on 10/30/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "TabBarViewController.h"
#import "SWRevealViewController.h"
#import "ReportDayViewController.h"
#import "ReportMonthViewController.h"
#import "ReportYearViewController.h"
#import "ReportCustomViewController.h"
@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *menu =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self.revealViewController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem = menu;
//    UIViewController *currentVC = self.navigationController.visibleViewController;
//    NSLog(@"The Current Class : %@", [self getClassName:currentVC]);
 //   self.title = @"Report";
    
}

//}
//- (NSString*) getClassName:(id) obj
//{
//    const char* className = class_getName([obj class]);
//    NSString *clsName = [@"" stringByAppendingFormat:@"%s",className];
//    
//    return clsName;
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

 //In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if([segue.identifier isEqualToString:@"tabMonth"]){
//   ReportDayViewController *controller = segue.destinationViewController;
//    self.title = @"Day Report";
//}
//    else if([segue.identifier isEqualToString:@"MonthID"]){
//        ReportMonthViewController *controller = segue.destinationViewController;
//        self.title = @"Month Report";
//
//    }
//    else if([segue.identifier isEqualToString:@"YearID"]){
//        ReportYearViewController *controller = segue.destinationViewController;
//        self.title = @"Year Report";
//
//    }
//}

@end
