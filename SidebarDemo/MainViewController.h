//
//  ViewController.h
//  SidebarDemo
//
//  Created by Simon on 28/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Category.h"
#import "HeadView.h"
#import "Protocol.h"
@class CategoryPom;
@class Profil;
@interface MainViewController : UIViewController <UITableViewDataSource , UITableViewDelegate >

- (IBAction)pressExpenseButton:(id)sender;
- (IBAction)pressIncomeButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *expenseBtn;
@property (weak, nonatomic) IBOutlet UIButton *incomeBtn;
@property (strong, nonatomic)CategoryPom *categorypom;
@property (strong, nonatomic)Profil *profil;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet NSMutableArray *listaKategorii;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign) int amountAggregate;
@property (nonatomic,assign) int saldo;
@property (nonatomic,assign) int amountPom;
@property (weak, nonatomic) IBOutlet UILabel *totalLabelIncome;
@property (weak, nonatomic) IBOutlet UILabel *saldoLabel;
@property (nonatomic,assign) int totalIncome;
@property (nonatomic,assign) int totalExpense;

@property (weak, nonatomic) IBOutlet UILabel *totalLabelExpense;
@property (weak, nonatomic) IBOutlet NSMutableArray *listaKAtegoriiImage;
@property (assign, nonatomic ) NSInteger didSection;
@property (assign, nonatomic ) NSInteger endSection;
@property (weak , nonatomic) IBOutlet NSMutableArray * listaa;


@end
