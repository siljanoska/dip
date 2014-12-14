//
//  ReportDayViewController.h
//  SidebarDemo
//
//  Created by Kireto on 9/16/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocol.h"
#import "Category.h"
@class Profil;
@interface ReportDayViewController : UIViewController{
    
    NSMutableIndexSet *expanding;
    NSMutableIndexSet *expandedSections;
    NSMutableArray *extendedArray;
    NSInteger brojac ;
    int i;

}

- (IBAction)pressIncomeBtn:(id)sender;
- (IBAction)pressExpenseBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *incomeBtn;
@property (weak, nonatomic) IBOutlet UIButton *expenseBtn;
@property  (weak , nonatomic) NSDate * currentDate ;
@property (weak, nonatomic) IBOutlet NSDateFormatter *formater;
@property (weak, nonatomic) NSString *dateString;
@property (weak, nonatomic) IBOutlet UIDatePicker *DayPicker;
@property (weak, nonatomic) IBOutlet UIView *DatePickerView;
@property (strong , nonatomic) IBOutlet NSMutableArray *pom;
@property (strong , nonatomic) IBOutlet NSMutableArray *listOfsection;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign) int amountAggregate;
@property (nonatomic,assign) int amountPom;
@property (nonatomic,assign) int vkupno;
@property (nonatomic,assign)  NSArray *listItemsFromCategory ;
@property (nonatomic, strong) Profil *profil;
@property (strong, nonatomic)CategoryPom *categorypom;

@property (nonatomic,assign) int vkupnoForCategory;
@property (strong, nonatomic) NSDate *dateFromPicker;

@property (weak, nonatomic) IBOutlet UIButton *dateDay;

- (IBAction)pressDateDay:(id)sender;
- (IBAction)pressClose:(id)sender;

//@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@end
