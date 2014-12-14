   //
//  ReportCustomViewController.m
//  SidebarDemo
//
//  Created by Kireto on 9/16/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//


//
//  ReportDayViewController.m
//  SidebarDemo
//
//  Created by Kireto on 9/16/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "ReportDayViewController.h"
#import "SWRevealViewController.h"
#import "ReportMonthViewController.h"
#import "MainViewController.h"
#import "AddCategory.h"
#import "AddItemViewController.h"
#import "AddNewItemViewController.h"
#import "AppDelegate.h"
#import "ReportDayCell.h"
#import "Category.h"
#import "Item.h"
#import "DateViewController.h"
#import "ReportCustomCell.h"
#import "ReportCustomViewController.h"
#import "Profil.h"
#import "CategoryPom.h"
#import "Globals.h"
@interface ReportCustomViewController ()

@property (strong) NSArray *objectCat;

@end

@implementation ReportCustomViewController

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
    [Globals saveDate:_dateString];
    
    NSDate * currentDate = [NSDate date];
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormater setDateFormat:@"dd-MMM-yyy"];
    _dateString = [ dateFormater stringFromDate: currentDate];
    _dateFromPicker = currentDate;
    [Globals saveDate:_dateString];
    NSLog(@"datumot e %@",_dateString);
    [_dateFromBtn setTitle:_dateString forState:UIControlStateNormal];
    [_dateToBtn setTitle:_dateString forState:UIControlStateNormal];
    _dateFromBtn.titleLabel.text = _dateString;
    _dateToBtn.titleLabel.text = _dateString;
    _dateFromString =[ dateFormater stringFromDate: currentDate];
    _dateToString =[ dateFormater stringFromDate: currentDate];
    _dateFrom = currentDate;
    _dateTo =currentDate;
    [Globals saveDateFrom:_dateFromString];
    [Globals saveDateTo:_dateToString];
    NSLog(@"datumot vo viewdidload e %@",_dateFromString);
    NSLog(@"datumot vo viewdidload e %@",_dateToString);
    [self.tableView reloadData];


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
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    
    if(_expenseBtn.selected){
        
        self.objectCat = [_categorypom.expense allObjects];
        _objectCat=[_objectCat sortedArrayUsingDescriptors:@[sort]];
        NSLog(@"brojot na elementi vo expense e %lu",(unsigned long)[_objectCat count]);

    }
    else {
        self.objectCat = [_categorypom.income allObjects];
        _objectCat=[_objectCat sortedArrayUsingDescriptors:@[sort]];
        NSLog(@"brojot na elementi vo income e %lu",(unsigned long)[_objectCat count]);

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
    NSLog(@"brojot na elementi vo expense e %lu",(unsigned long)[_objectCat count]);

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self tableView:tableView canCollapseSection:section])
    {
        i=0;
        
        if ([expandedSections containsIndex:section])
        {
            Category *category = [self.objectCat objectAtIndex:section];
            NSArray *listItemsFromCategory = [category.items allObjects];
            NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
            [dateFormater setDateFormat:@"dd-MMM-yyy"];
            //NSString *pickedDay = [ dateFormater stringFromDate: _dateFromPicker];
            _pom = [[NSMutableArray alloc] init];
            
            
            
            if(_expenseBtn.selected){
                
                for (Item *item in listItemsFromCategory){
                    
                    NSString *itemDate = [ dateFormater stringFromDate: item.date];
                    NSDate *dateitem = [dateFormater dateFromString:itemDate];
                    NSLog(@"Datumot e %@" , itemDate);
                    
                    _dateFrom = [dateFormater dateFromString:_dateFromString ];
                    
                    NSLog(@"Datumot e %@" , _dateFrom);
                    NSLog(@"Datumot e %@" , _dateFromString);

                    
                    _dateTo = [dateFormater dateFromString:_dateToString];
                    
                    // NSDate * itemdate = [dateFormater1 dateFromString:itemDateString];
                    
                    NSLog(@"Datumot e %@" , _dateTo);
                    NSLog(@"Datumot e %@" , _dateToString);

                    
                    
                    NSComparisonResult compareResult1 = [dateitem compare:_dateFrom];
                    
                    NSComparisonResult compareResult2 = [dateitem compare:_dateTo];
                    
                    
                    
                    if((compareResult2 == NSOrderedAscending || compareResult2 == NSOrderedSame )&&  (compareResult1 == NSOrderedDescending || (compareResult1 == NSOrderedSame))) {
                        
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
                        
                        _dateFrom = [dateFormater dateFromString:_dateFromString ];
                        
                        NSDate *dateitem = [dateFormater dateFromString:itemDate];
                        NSLog(@"Datumot e %@" , itemDate);

                        
                        _dateTo = [dateFormater dateFromString:_dateToString];
                        
                        // NSDate * itemdate = [dateFormater1 dateFromString:itemDateString];
                        
                        NSLog(@"Datumot e %@" , _dateTo);
                        
                        
                        
                        NSComparisonResult compareResult1 = [dateitem compare:_dateFrom];
                        
                        NSComparisonResult compareResult2 = [dateitem compare:_dateTo];
                        
                        
                        
                        if((compareResult2 == NSOrderedAscending || compareResult2 == NSOrderedSame )&&  (compareResult1 == NSOrderedDescending || (compareResult1 == NSOrderedSame))) {
                            
                            
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



- (ReportDayCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    ReportDayCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell= [[ReportDayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];    }
    
    // Configure the cell...
    
    
    if ([self tableView:tableView canCollapseSection:indexPath.section])
    {
        
        if (!indexPath.row)
        {
            Category *category =[_objectCat objectAtIndex:indexPath.section];
            _amountPom =0;
            NSArray *listItemsFromCategory = [category.items allObjects];
            
            NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
            
            [dateFormater setDateFormat:@"dd-MMM-yyy" ];
            
            
            
            if(_expenseBtn.selected){
                
                if (listItemsFromCategory && [listItemsFromCategory count]) {
                    
                    for (Item *item in listItemsFromCategory) {
                        NSString *itemDate = [ dateFormater stringFromDate: item.date];
                        NSDate *dateitem = [dateFormater dateFromString:itemDate];

                        
                        _dateFrom = [dateFormater dateFromString:_dateFromString ];
                        
              
                        
                        
                        _dateTo = [dateFormater dateFromString:_dateToString];
                        
                        // NSDate * itemdate = [dateFormater1 dateFromString:itemDateString];
      
                        
                        NSLog(@"Datumot e %@" , _dateFrom);
                        NSLog(@"Datumot e %@" , dateitem);
                        
                        
                        NSComparisonResult compareResult1 = [dateitem compare:_dateFrom];
                        
                        NSComparisonResult compareResult2 = [dateitem compare:_dateTo];
                        
                        
                        
                        if((compareResult2 == NSOrderedAscending || compareResult2 == NSOrderedSame )&&  (compareResult1 == NSOrderedDescending || (compareResult1 == NSOrderedSame))) {
                            

                            _amountPom += [item.amount intValue];
                        }
                    }
                }
            }
            else {
                if (listItemsFromCategory && [listItemsFromCategory count]) {
                    
                    for (Item *item in listItemsFromCategory) {
                        NSString *itemDate = [ dateFormater stringFromDate: item.date];
                        
                        NSDate *dateitem = [dateFormater dateFromString:itemDate];

                        _dateFrom = [dateFormater dateFromString:_dateFromString ];
                        
                  
                        
                        
                        
                        _dateTo = [dateFormater dateFromString:_dateToString];
                        
                        // NSDate * itemdate = [dateFormater1 dateFromString:itemDateString];
                        
                        NSLog(@"Datumot e %@" , _dateTo);
                        NSLog(@"Datumot e %@" , dateitem);
                        
                        
                        
                        NSComparisonResult compareResult1 = [dateitem compare:_dateFrom];
                        
                        NSComparisonResult compareResult2 = [dateitem compare:_dateTo];
                        
                        
                        
                        if((compareResult2 == NSOrderedAscending || compareResult2 == NSOrderedSame )&&  (compareResult1 == NSOrderedDescending || (compareResult1 == NSOrderedSame))) {
                            
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
{
    if ([self tableView:tableView canCollapseSection:indexPath.section])
    {
        if (!indexPath.row)
        {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            NSInteger section = indexPath.section;
            NSLog(@"Sekcijata e %ldl",(long)section);
            BOOL currentlyExpanded = [expandedSections containsIndex:section];
            NSInteger rows;
            NSMutableArray *tmpArray = [NSMutableArray array];
            ReportDayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
            cell =(ReportDayCell*)[tableView cellForRowAtIndexPath:indexPath];
            
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
                
              //  ReportDayCell *cell = [tableView cellForRowAtIndexPath:indexPath];
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
                    
                  //  ReportDayCell *cell = [tableView cellForRowAtIndexPath:indexPath];
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


- (IBAction)swipeRightPop:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)pressDateFromBtn:(id)sender {
    _datePickerView.layer.borderColor =[UIColor blackColor].CGColor;
    _datePickerView.layer.borderWidth =3.0f;
    _tableView.userInteractionEnabled =NO;
    [self.view sendSubviewToBack:_tableView];
    flagFrom = YES;
    fragTo =NO;
}

- (IBAction)pressDateToBtn:(id)sender {
    _datePickerView.layer.borderColor =[UIColor blackColor].CGColor;
    _datePickerView.layer.borderWidth =3.0f;
    _tableView.userInteractionEnabled =NO;
    [self.view sendSubviewToBack:_tableView];
    flagFrom = NO;
    fragTo =YES;

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

- (IBAction)pressDoneBtn:(id)sender {
    _tableView.userInteractionEnabled =YES;
    NSDateFormatter *dateFormater =[[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"dd-MMM-yyy"];
   // _dateString = [ dateFormater stringFromDate: _dayPicker.date];
   // _dateFromPicker =_dayPicker.date;
    
    if(flagFrom){
            _dateFrom =_dayPicker.date;
        _dateFromString = [ dateFormater stringFromDate: _dayPicker.date];
        [_dateFromBtn setTitle:_dateFromString forState:UIControlStateNormal];
        _dateFromBtn.titleLabel.text =_dateFromString;
        [Globals saveDateFrom:_dateFromString];
        NSLog(@"datumot od pickerot e %@", _dateFrom);
        NSLog(@"datumot od pickerot e %@", _dateFromString);

    }
    else if(fragTo) {
  
        _dateTo =_dayPicker.date;
        _dateToString = [ dateFormater stringFromDate: _dayPicker.date];
        [_dateToBtn setTitle:_dateToString forState:UIControlStateNormal];
        _dateToBtn.titleLabel.text =_dateToString;
        [Globals saveDateTo:_dateToString];

        NSLog(@"datumot od pickerot e %@", _dateTo);
        NSLog(@"datumot od pickerot e %@", _dateToString);

    }
    [self.view sendSubviewToBack:_datePickerView];
    [_tableView reloadData];

}

- (IBAction)pressCloseBtn:(id)sender {
    _tableView.userInteractionEnabled =YES;
    [self.view sendSubviewToBack:_datePickerView];

}

@end