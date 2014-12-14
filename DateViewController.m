//
//  DateViewController.m
//  SidebarDemo
//
//  Created by Kireto on 9/17/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "DateViewController.h"

@interface DateViewController ()

@end

@implementation DateViewController

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
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)done:(id)sender {
   // NSDAte *datePicked = [[NSDate] datePicker.date];
    
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"dd-MMM-yyy " ];
    _date = [ dateFormater stringFromDate: _datePicker.date];
    
    NSLog(@"vkupno e e %@" ,_datePicker.date);
    [self.delegate dateString:_date];
    [self.delegate dateDate:_datePicker.date];
    [self.navigationController popViewControllerAnimated:YES];
    //  [self dismissViewControllerAnimated:YES completion:nil];
}
@end
