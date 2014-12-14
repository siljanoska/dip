//
//  PieChartReport.h
//  SidebarDemo
//
//  Created by TheMac on 10/27/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLPieChart.h"
#import "Category.h"
@class Profil;

@interface PieChartReport : UIViewController

@property (retain, nonatomic) IBOutlet DLPieChart *pieChartExpense;
@property (retain, nonatomic) IBOutlet DLPieChart *pieChartIncome;

@property (strong ,nonatomic) IBOutlet NSString *dayPickerDate;
@property (nonatomic,assign) int amountPom;
@property (nonatomic,assign) int vkupno;
@property (weak, nonatomic) NSString *dateStringFromPicker;
@property (weak, nonatomic) NSString *dateString;
- (IBAction)pressExpenseBtn:(id)sender;
- (IBAction)pressIncomeBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *expenseBtn;
@property (weak, nonatomic) IBOutlet UIButton *incomeBtn;
@property (strong, nonatomic) Profil *profil;
@property (strong, nonatomic)CategoryPom *categorypom;

-(int)amountAgregator:(Category *)category;

@end
