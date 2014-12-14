//
//  ReportDayViewController.m
//  SidebarDemo
//
//  Created by Kireto on 9/16/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "ReportMonthViewController.h"
#import "ReportCustomViewController.h"
#import "SWRevealViewController.h"
#import "MainViewController.h"
#import "AddCategory.h"
#import "AddItemViewController.h"
#import "AddNewItemViewController.h"
#import "AppDelegate.h"
#import "ReportMonthCell.h"
#import "Category.h"
#import "DTCustomColoredAccessory.h"
#import "Globals.h"
#import "Profil.h"
#import "CategoryPom.h"
#import "Item.h"
#import "TabBarViewController.h"

@interface ReportMonthViewController ()

@property (strong) NSArray *objectCat;

@end

@implementation ReportMonthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    _profil = [Globals loadCurrentProfil];
    _categorypom = _profil.categoryProfil;
    NSLog(@"category pom za profil e %@",_categorypom.description);
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    _objectCat=[_objectCat sortedArrayUsingDescriptors:@[sort]];
    _expenseBtn.selected = YES;
 //   self.navigationController.title = @"Report Month";
  //  self.navigationItem.title = @"title";
  //  self.title = @"Report Month";
    [Globals saveDate:_dateString];
    [self.tableView reloadData];

    NSDate * currentDate = [NSDate date];
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormater setDateFormat:@"MMM-yyy"];
    _dateString = [ dateFormater stringFromDate: currentDate];
    _dateFromPicker = currentDate;
   [Globals saveDate:_dateString];
    NSLog(@"datumot e %@",_dateString);
    [_dateMonthButton setTitle:_dateString forState:UIControlStateNormal];
    _dateMonthButton.titleLabel.text =_dateString;
    brojac =0;
    
    if (!expandedSections)
    {
        expandedSections =[[NSMutableIndexSet alloc] init];
      
        extendedArray = [[NSMutableArray alloc] init];
        
    }
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [super viewDidAppear:animated];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    if(_expenseBtn.selected){
        
        self.objectCat = [_categorypom.expense allObjects];
        _objectCat=[_objectCat sortedArrayUsingDescriptors:@[sort]];
        
    }
    else {
        self.objectCat = [_categorypom.income allObjects];
        _objectCat=[_objectCat sortedArrayUsingDescriptors:@[sort]];
        
    }
    [self.tableView reloadData];
    
}


- (BOOL)tableView:(UITableView *)tableView canCollapseSection:(NSInteger)section
{
    if (section>=0) return YES;
    
    return NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [_objectCat count];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self tableView:tableView canCollapseSection:section])
    {
        i=0;
        
        if ([expandedSections containsIndex:section])
        {
            Category *category =[self.objectCat objectAtIndex:section];
           
            NSArray *listItemsFromCategory = [category.items allObjects];
            
            NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
            
            [dateFormater setDateFormat:@"MMM-yyy" ];
            
        //    NSString *pickedDay = [ dateFormater stringFromDate: _dateFromPicker];
            _pom = [[NSMutableArray alloc] init];
            
            if(_expenseBtn.selected){
                
                for (Item *item in listItemsFromCategory){
                    
                    NSString *itemDate = [ dateFormater stringFromDate: item.date];
                    
                    if([_dateString isEqualToString:itemDate]){
                        
                        [_pom addObject:item];
                        i++;
                    }
                }
                return i+1;
            }
            else {
                if(_incomeBtn.selected){
                    
                    for (Item *item in listItemsFromCategory){
                        
                        NSString *itemDate = [ dateFormater stringFromDate: item.date];
                        
                        if([_dateString isEqualToString:itemDate]){
                            
                            [_pom addObject:item];
                            i++;
                        }
                    }
                    return i+1;
                }
                
            }
        }
        
        return 1; // only top row showing
    }
    
    // Return the number of rows in the section.
    return 1;
}

- (ReportMonthCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    ReportMonthCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell= [[ReportMonthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];    }
    
    // Configure the cell...
    
    
    if ([self tableView:tableView canCollapseSection:indexPath.section])
    {
        if (!indexPath.row)
        {
            
            Category *category =[_objectCat objectAtIndex:indexPath.section];
            _amountPom =0;
            
            NSArray *listItemsFromCategory = [category.items allObjects];
            NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
            
            [dateFormater setDateFormat:@"MMM-yyy" ];
            
         //   NSString *pickedDay = [ dateFormater stringFromDate: _dateFromPicker];
            
         //   NSString *currentDay = [dateFormater stringFromDate:_currentDate];
            
            if(_expenseBtn.selected){
                
                if (listItemsFromCategory && [listItemsFromCategory count]) {
                    
                    for (Item *item in listItemsFromCategory) {
                        NSString *itemDate = [ dateFormater stringFromDate: item.date];
                        
                        if([_dateString isEqualToString:itemDate]){
                            _amountPom += [item.amount intValue];
                        }
                    }
                }
            }
            else {
                if (listItemsFromCategory && [listItemsFromCategory count]) {
                    
                    for (Item *item in listItemsFromCategory) {
                        NSString *itemDate = [ dateFormater stringFromDate: item.date];
                        
                        if([_dateString isEqualToString:itemDate]){
                            _amountPom += [item.amount intValue];
                        }
                    }
                    
                }
            }
                    cell.nameCategory.text=category.name;
                    cell.categoryImage.image =[UIImage imageNamed:category.imageName];
                    cell.vkupnoCell.text = [NSString stringWithFormat:@"%d", _amountPom];
                    [cell.nameCategory sizeToFit];
                    [cell.vkupnoCell sizeToFit];

            if ([expandedSections containsIndex:indexPath.section])
            {
                cell.accessoryView = [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeUp];
            }
            else
            {
                cell.accessoryView = [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeDown];
            }
        }
        else
        {
            // all other rows
            Category *category =[_objectCat objectAtIndex:indexPath.section];
            
            NSLog(@"description category is: %@", category.description);
            Item *item= [_pom objectAtIndex:indexPath.row-1];
            
            cell.categoryImage.image =[UIImage imageNamed:@"tag.png"];
            
            cell.nameCategory.text=item.descript;
            NSLog(@"description item is: %@", item.description);
            
            cell.vkupnoCell.text = [NSString stringWithFormat:@"%@", item.amount];
            // first=true;
            [cell.vkupnoCell sizeToFit];
            [cell.nameCategory sizeToFit];

        }
}
    else
    {
        cell.accessoryView = nil;
        cell.textLabel.text = @"Normal Cell";
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{ if ([self tableView:tableView canCollapseSection:indexPath.section])
{
    if (!indexPath.row)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        NSInteger section = indexPath.section;
        NSLog(@"Sekcijata e %ldl",(long)section);
        BOOL currentlyExpanded = [expandedSections containsIndex:section];
        NSInteger rows;
        NSMutableArray *tmpArray = [NSMutableArray array];
        ReportMonthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        cell =(ReportMonthCell*)[tableView cellForRowAtIndexPath:indexPath];

        
        if(_expenseBtn.selected){
            
            if (currentlyExpanded || [extendedArray count]>0){
                
                brojac = [(NSNumber *)[extendedArray objectAtIndex:0] intValue];
                NSLog(@"brojot %ld " ,(long)brojac);
                
                rows = [self tableView:tableView numberOfRowsInSection:brojac];
                NSLog(@"brojot na redovi e e %ldl, %@l",(long)rows ,[extendedArray objectAtIndex:0]);
                
                [expandedSections removeIndex:brojac];
            }
            
            else
            {
                [expandedSections addIndex:section];
                NSLog(@"sekcijata e %i" , (int)section);
                rows = [self tableView:tableView numberOfRowsInSection:section];
                NSLog(@"brojot na redovi e e %ldl",(long)rows );
                
            }
            
            if([extendedArray count] == 0 ){
                for (int j=1; j<rows; j++)
                {
                    NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:j
                                                                   inSection:section];
                    [tmpArray addObject:tmpIndexPath];
                }
            }
            else {
                for (int j=1; j<rows; j++)
                {
                    NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:j
                                                                   inSection:brojac];
                    [tmpArray addObject:tmpIndexPath];
                    NSLog(@"tmp array %@" ,tmpArray.description);
                }
            }
            
         //   ReportMonthCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            if (currentlyExpanded || [extendedArray count]>0)
            {
                [tableView deleteRowsAtIndexPaths:tmpArray
                                 withRowAnimation:UITableViewRowAnimationTop];
                cell.accessoryView = [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeDown];
                [extendedArray removeAllObjects];
            }
            else
            {
                NSLog (@"nizata e  tmpArray %@" , tmpArray.description);
                [tableView insertRowsAtIndexPaths:tmpArray
                                 withRowAnimation:UITableViewRowAnimationTop];
                [extendedArray addObject: [NSNumber numberWithInteger: section]];
                cell.accessoryView =  [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeUp];
            }
        }
        
        else {
            if(_incomeBtn.selected){
                
                if (currentlyExpanded || [extendedArray count]>0)
                {  brojac = [(NSNumber *)[extendedArray objectAtIndex:0] intValue];
                    NSLog(@"brojot %ld " ,(long)brojac);
                    
                    rows = [self tableView:tableView numberOfRowsInSection:brojac];
                    NSLog(@"brojot na redovi e e %ldl, %@l",(long)rows ,[extendedArray objectAtIndex:0]);
                    [expandedSections removeIndex:brojac];
                    
                }
                
                else
                {
                    // rows = [self tableView:tableView numberOfRowsInSection:section];
                    [expandedSections addIndex:section];
                    NSLog(@"sekcijata e %i" , (int)section);
                    rows = [self tableView:tableView numberOfRowsInSection:section];
                    NSLog(@"brojot na redovi e e %ldl",(long)rows );
                    
                }
                NSLog(@"extendedArray %lul" , (unsigned long)[extendedArray count]);
                if([extendedArray count] == 0 ){
                    for (int j=1; j<rows; j++)
                    {
                        NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:j
                                                                       inSection:section];
                        [tmpArray addObject:tmpIndexPath];
                    }
                }
                else {
                    for (int j=1; j<rows; j++)
                    {
                        NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:j
                                                                       inSection:brojac];
                        [tmpArray addObject:tmpIndexPath];
                        NSLog(@"tmp array %@" ,tmpArray.description);
                    }
                }
                
              //  ReportMonthCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                if (currentlyExpanded || [extendedArray count]>0)
                {
                    [tableView deleteRowsAtIndexPaths:tmpArray
                                     withRowAnimation:UITableViewRowAnimationTop];
                    //  cell.accessoryView = nil;
                    cell.accessoryView = [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeDown];
                    [extendedArray removeAllObjects];
                }
                else
                {
                    NSLog (@"nizata e  tmpArray %@" , tmpArray.description);
                    [tableView insertRowsAtIndexPaths:tmpArray
                                     withRowAnimation:UITableViewRowAnimationTop];
                    // [extendedArray addObject:(int)section];
                    [extendedArray addObject: [NSNumber numberWithInteger: section]];
                    cell.accessoryView =  [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeUp];
                    // cell.accessoryView = nil;
                }
            }
        }
    }
}
}

-(int)amountAgregatorItemInCategory:(Category *)category{
    
    _amountPom =0;
    NSArray *listItemsFromCategory = [category.items allObjects];
    if (listItemsFromCategory && [listItemsFromCategory count]) {
        
        for (Item *item in listItemsFromCategory) {
            
            _amountPom += [item.amount intValue];
        }
    }
    return _amountPom;
    
}
-(int)amountAgregatorTotal:(NSArray *)listObject
{
    int total = 0;
    for (int n=0 ; n < [listObject count]; n++ ){
        _amountPom =0;
        Category *category = [self.objectCat objectAtIndex:n];
        NSArray *listItemsFromCategory = [category.items allObjects];
        if (listItemsFromCategory && [listItemsFromCategory count]) {
            
            for (Item *item in listItemsFromCategory) {
                _amountPom += [item.amount intValue];
            }
            total +=_amountPom;
        }
    }
    return total;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)swipeLeft:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)pressExpenseBtn:(id)sender {
    if (!_expenseBtn.selected) {
        
        self.objectCat = [_categorypom.expense allObjects];
        NSLog(@"listata ima %lu elementi",(unsigned long)[self.objectCat count]);
        _incomeBtn.selected = NO;
        _expenseBtn.selected = YES;
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
        _objectCat=[_objectCat sortedArrayUsingDescriptors:@[sort]];
        
        [_tableView reloadData];
        
        
    }
}

- (IBAction)pressClose:(id)sender {
    _tableView.userInteractionEnabled =YES;
    [self.view sendSubviewToBack:_DatePickerView];
 
}

- (IBAction)pressDone:(id)sender {
    _tableView.userInteractionEnabled =YES;
    NSDateFormatter *dateFormater =[[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"MMM-yyy"];
    _dateString = [ dateFormater stringFromDate: _DayPicker.date];
    _dateFromPicker =_DayPicker.date;

    
    [_dateMonthButton setTitle:_dateString forState:UIControlStateNormal];
    _dateMonthButton.titleLabel.text =_dateString;
    [self.view sendSubviewToBack:_DatePickerView];
    [_tableView reloadData];
}

- (IBAction)dateMonthButton:(id)sender {
    // _DatePickerView = [[UIView alloc] initWithFrame:CGRectMake(0, 120, 320, 180)];
    // _DatePickerView.backgroundColor =[UIColor redColor];
    _DatePickerView.layer.borderColor =[UIColor blackColor].CGColor;
    _DatePickerView.layer.borderWidth =3.0f;
    //   if((!ispressOneTime)){
    // _tableView.backgroundColor = [UIColor greenColor];
    _tableView.userInteractionEnabled =NO;
    
    //[self.view addSubview:_DatePickerView ];
    
    [self.view sendSubviewToBack:_tableView];
    //        _DatePickerView.frame.origin.x, _DatePickerView.frame.origin.y,    _DatePickerView.frame.size.width,_DatePickerView.frame.size.height )
    //
    //   [self doTransitionWithType:UIViewAnimationOptionTransitionCrossDissolve];
    //        ispressOneTime = YES ;
    //    }
    //    else {
    //       // _tableView.userInteractionEnabled =YES;
    //       [self.view sendSubviewToBack:_DatePickerView];
    //
    //      // [self doTransitionWithType:UIViewAnimationOptionTransitionCrossDissolve];
    //
    //        ispressOneTime = NO;
    //        ;
    //    }

}
- (IBAction)pressIncomeBtn:(id)sender {
    if (!_incomeBtn.selected) {
        
        self.objectCat = [_categorypom.income allObjects];
        NSLog(@"listata ima %lu elementi",(unsigned long)[self.objectCat count]);
        
        _incomeBtn.selected = YES;
        _expenseBtn.selected = NO;
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
        _objectCat=[_objectCat sortedArrayUsingDescriptors:@[sort]];
        
        [_tableView reloadData];
    }

}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
    if([segue.identifier isEqualToString:@"tabYear"]){
        TabBarViewController *tab = segue.destinationViewController;
        tab.title = @"Year Report";
        
  }
}
@end
