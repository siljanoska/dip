//
//  ReportCustomViewController.h
//  SidebarDemo
//
//  Created by Kireto on 9/16/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocol.h"
@class Profil;
@class CategoryPom;
@interface ReportCustomViewController : UIViewController {
    NSMutableIndexSet *expanding;
    NSMutableIndexSet *expandedSections;
    NSMutableArray *extendedArray;
    NSInteger brojac ;
    BOOL flagFrom ;
    BOOL fragTo;
    int i;
}
@property (strong , nonatomic) IBOutlet NSMutableArray *pom;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic ) IBOutlet NSMutableArray *listaKategorii;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign) int amountAggregate;
@property (nonatomic,assign) int amountPom;
@property (weak , nonatomic) IBOutlet NSDate *dateFrom;
@property (weak , nonatomic) IBOutlet NSDate *dateTo;
@property (strong , nonatomic) IBOutlet NSString *dateToString;
@property (strong , nonatomic) IBOutlet NSString *dateFromString;



@property (weak, nonatomic) IBOutlet UIButton *dateFromBtn;
@property (weak, nonatomic) IBOutlet UIButton *dateToBtn;

- (IBAction)swipeRightPop:(id)sender;

- (IBAction)pressDateFromBtn:(id)sender;
- (IBAction)pressDateToBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *expenseBtn;
@property (weak, nonatomic) IBOutlet UIButton *incomeBtn;
- (IBAction)pressExpenseBtn:(id)sender;
- (IBAction)pressIncomeBtn:(id)sender;
- (IBAction)pressDoneBtn:(id)sender;
- (IBAction)pressCloseBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *datePickerView;
@property (weak, nonatomic) IBOutlet UIDatePicker *dayPicker;
@property (weak, nonatomic) NSString *dateString;
@property (nonatomic,assign) int vkupno;
@property (nonatomic, strong) Profil *profil;
@property (nonatomic, strong) CategoryPom *categorypom;
@property (weak , nonatomic) IBOutlet NSDate *dateFromPicker;
@end

