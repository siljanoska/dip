//
//  ReportYearViewController.h
//  SidebarDemo
//
//  Created by Kireto on 9/16/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Profil;
@class CategoryPom;
@interface ReportYearViewController : UIViewController{
    NSInteger brojac ;
    NSMutableArray *extendedArray;
    int i;
    NSMutableIndexSet *expandedSections;
}

//- (IBAction)swipeLeft:(id)sender;
- (IBAction)pressDateYearButton:(id)sender;
- (IBAction)swipeRightPop:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIButton *dateYearButton;
@property (strong , nonatomic) IBOutlet NSMutableArray *pom;
@property (weak, nonatomic) IBOutlet UIDatePicker *DayPicker;
@property (weak, nonatomic) IBOutlet UIView *DatePickerView;
@property (strong, nonatomic) NSDate *dateFromPicker;
@property (weak , nonatomic) NSDate * currentDate ;
@property (weak, nonatomic) NSString *dateString;
@property (nonatomic,assign) int amountPom;
@property (nonatomic,assign) int vkupno;
@property (nonatomic,assign) int vkupnoForCategory;
- (IBAction)pressExpenseBtn:(id)sender;
- (IBAction)pressIncomeBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *expenseBtn;
@property (weak, nonatomic) IBOutlet UIButton *incomeBtn;

@property (weak, nonatomic) Profil *profil;
@property (weak, nonatomic) CategoryPom *categorypom;


@property (weak, nonatomic ) IBOutlet NSMutableArray *listaKategorii;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
