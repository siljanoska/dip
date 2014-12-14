//
//  PieChartReportYear.m
//  SidebarDemo
//
//  Created by TheMac on 10/30/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "PieChartReportYear.h"
#import "SWRevealViewController.h"
#import "Category.h"
#import "Item.h"
#import "Globals.h"
#import "Profil.h"
#import "CategoryPom.h"


@interface PieChartReportYear ()
@property (strong) NSArray *objectCat;

@end

@implementation PieChartReportYear

- (void)viewDidLoad {
    [super viewDidLoad];
    _profil = [Globals loadCurrentProfil];
    _categorypom = _profil.categoryProfil;
    self.objectCat = [_categorypom.expense allObjects];
    _expenseBtn.selected = YES;
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    _objectCat=[_objectCat sortedArrayUsingDescriptors:@[sort]];
    
    
    NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:100];
    NSMutableArray *categoryName = [NSMutableArray arrayWithCapacity:100];
    
    _dateStringFromPicker =[Globals loadSaveData];
    
    for (int i=0 ; i<[_objectCat count] ;i++){
        
        Category *cat = [_objectCat objectAtIndex:i];
        NSNumber *num =[NSNumber numberWithInt:[self amountAgregator:cat]];
        [dataArray addObject:num];
        [categoryName addObject:cat.name];
        
    }
    
    [self.pieChartViewExpense renderInLayer1: self.pieChartViewExpense dataArray:dataArray nameArray:categoryName];
    
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:100];
    NSMutableArray *categoryName = [NSMutableArray arrayWithCapacity:100];
    _profil = [Globals loadCurrentProfil];
    _categorypom = _profil.categoryProfil;
    self.objectCat = [_categorypom.expense allObjects];
    _expenseBtn.selected = YES;
    _incomeBtn.selected = NO;
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    _objectCat=[_objectCat sortedArrayUsingDescriptors:@[sort]];
    [dataArray removeAllObjects];
    [categoryName removeAllObjects];
    
    _dateStringFromPicker =[Globals loadSaveData];
    for (int i=0 ; i<[_objectCat count] ;i++){
        Category *cat = [_objectCat objectAtIndex:i];
        NSNumber *num =[NSNumber numberWithInt:[self amountAgregator:cat]];
        [dataArray addObject:num];
        [categoryName addObject:cat.name];
    }
    [self.pieChartViewIncome removeFromSuperview];
    [self.pieChartViewExpense renderInLayer1: self.pieChartViewExpense dataArray:dataArray nameArray:categoryName];
    [self.view addSubview:self.pieChartViewExpense];
    
}

-(int)amountAgregator:(Category *)category{
    _vkupno = 0;
    _amountPom =0;
    NSArray *listItemsFromCategory = [category.items allObjects];
    
    if (listItemsFromCategory && [listItemsFromCategory count] ) {
        
        for (Item *item in listItemsFromCategory) {
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyy"];
            _dateString = [dateFormatter stringFromDate:item.date];
            
            NSLog(@"datumot na itemot e %@ ", _dateString);
            NSLog(@"datumot na pickerot e %@ ", _dateStringFromPicker);
            
            if( [_dateString isEqual:_dateStringFromPicker]){
                
                _amountPom += [item.amount intValue];
                
            }
            else
            {
                _amountPom += 0;
            }
            NSLog(@"amount e %d",(int)_amountPom);
        }
        return _amountPom;
    }
    return _amountPom;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)pressExpenseBtn:(id)sender {
    self.objectCat = [_categorypom.expense allObjects];
    NSLog(@"listata ima %lu elementi",(unsigned long)[self.objectCat count]);
    _incomeBtn.selected = NO;
    _expenseBtn.selected = YES;
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    _objectCat=[_objectCat sortedArrayUsingDescriptors:@[sort]];
    
    
    NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:100];
    NSMutableArray *categoryName = [NSMutableArray arrayWithCapacity:100];
    
    [dataArray removeAllObjects];
    [categoryName removeAllObjects];
    
    
    NSLog(@"DATUMOT E e %@ ", [Globals loadSaveData]);
    _dateStringFromPicker =[Globals loadSaveData];
    NSLog(@"DATUMOT E e %lul ", (unsigned long)[_objectCat count]);
    
    for (int i=0 ; i<[_objectCat count] ;i++){
        NSLog(@"listata ima %lu elementi",(unsigned long)[_objectCat count]);
        Category *cat = [_objectCat objectAtIndex:i];
        NSLog(@"Categorjata e %@ ", cat.description);
        NSNumber *num =[NSNumber numberWithInt:[self amountAgregator:cat]];
        [dataArray addObject:num];
        [categoryName addObject:cat.name];
        NSLog(@"Brojot koj se dodava vo listata e e %@ ", num);
        
    }
    [self.pieChartViewIncome removeFromSuperview];
    [self.pieChartViewExpense renderInLayer1: self.pieChartViewExpense dataArray:dataArray nameArray:categoryName];
    [self.view addSubview:self.pieChartViewExpense];
}

- (IBAction)pressIncomeBtn:(id)sender {
    self.objectCat = [_categorypom.income allObjects];
    NSLog(@"listata ima %lu elementi",(unsigned long)[self.objectCat count]);
    _incomeBtn.selected = YES;
    _expenseBtn.selected = NO;
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    _objectCat=[_objectCat sortedArrayUsingDescriptors:@[sort]];
    
    
    NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:100];
    NSMutableArray *categoryName = [NSMutableArray arrayWithCapacity:100];
    
    [dataArray removeAllObjects];
    [categoryName removeAllObjects];
    
    
    NSLog(@"DATUMOT E e %@ ", [Globals loadSaveData]);
    _dateStringFromPicker =[Globals loadSaveData];
    NSLog(@"DATUMOT E e %lul ", (unsigned long)[_objectCat count]);
    
    for (int i=0 ; i<[_objectCat count] ;i++){
        NSLog(@"listata ima %lu elementi",(unsigned long)[_objectCat count]);
        Category *cat = [_objectCat objectAtIndex:i];
        NSLog(@"Categorjata e %@ ", cat.description);
        NSNumber *num =[NSNumber numberWithInt:[self amountAgregator:cat]];
        [dataArray addObject:num];
        [categoryName addObject:cat.name];
        NSLog(@"Brojot koj se dodava vo listata e e %@ ", num);
        
    }
    [self.pieChartViewExpense removeFromSuperview];
    [self.pieChartViewIncome renderInLayer1: self.pieChartViewIncome dataArray:dataArray nameArray:categoryName];
    [self.view addSubview:self.pieChartViewIncome];
    
}
@end
