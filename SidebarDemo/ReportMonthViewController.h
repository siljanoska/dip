//
//  ReportMonthViewController.h
//  SidebarDemo
//
//  Created by Kireto on 9/16/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Profil;
@class CategoryPom;
@interface ReportMonthViewController : UIViewController
{
    NSInteger brojac ;
    NSMutableArray *extendedArray;
    NSMutableIndexSet *expandedSections;
    int i;

}
@property (nonatomic, strong) Profil *profil;
@property (strong, nonatomic)CategoryPom *categorypom;


- (IBAction)pressClose:(id)sender;
- (IBAction)pressDone:(id)sender;
- (IBAction)dateMonthButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *dateMonthButton;
@property (strong , nonatomic) IBOutlet NSMutableArray *pom;
@property (weak, nonatomic) IBOutlet UIDatePicker *DayPicker;
@property (weak, nonatomic) IBOutlet UIView *DatePickerView;
@property (strong, nonatomic) NSDate *dateFromPicker;
@property  (weak , nonatomic) NSDate * currentDate ;
@property (weak, nonatomic) NSString *dateString;
@property (nonatomic,assign) int amountPom;
@property (nonatomic,assign) int vkupno;
@property (nonatomic,assign) int vkupnoForCategory;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic ) IBOutlet NSMutableArray *listaKategorii;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)swipeLeft:(id)sender;
- (IBAction)pressExpenseBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *expenseBtn;
- (IBAction)pressIncomeBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *incomeBtn;


//@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@end

