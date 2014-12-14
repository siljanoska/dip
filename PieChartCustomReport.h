//
//  PieChartCustomReport.h
//  SidebarDemo
//
//  Created by TheMac on 12/11/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLPieChart.h"
@class Profil;
@class CategoryPom;


@interface PieChartCustomReport : UIViewController
- (IBAction)pressExpenseBtn:(id)sender;
- (IBAction)pressIncomeBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *expenseBtn;
@property (weak, nonatomic) IBOutlet UIButton *incomeBtn;

@property (retain , nonatomic) IBOutlet DLPieChart *pieChartViewExpense;
@property (retain , nonatomic) IBOutlet DLPieChart *pieChartViewIncome;

@property (strong ,nonatomic) IBOutlet NSString *dayPickerDate;

@property (nonatomic,assign) int amountPom;
@property (nonatomic,assign) int vkupno;
@property (weak, nonatomic) NSString *dateStringFromPicker;
@property (weak, nonatomic) NSString *dateString;
@property (strong, nonatomic) Profil *profil;
@property (strong, nonatomic)CategoryPom *categorypom;

@property (strong,nonatomic) NSDate *dateFrom;
@property (strong,nonatomic) NSDate *dateTo;

@end
