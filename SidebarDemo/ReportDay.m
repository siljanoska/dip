//
//  ReportDay.m
//  SidebarDemo
//
//  Created by Kireto on 9/19/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "ReportDay.h"
#import "ReportDayCell.h"
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

@implementation ReportDay
//@property (nonatomic,strong) NSMutableArray *objectCategoryArray;



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Fetch the devices from persistent data store
        NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Category"];
        self.objectCat = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
        [self.tableView reloadData];
        
        [self AmountAgregator];
        
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_objectCat count];
}

- (ReportDayCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellId = @"Cell";
    
    ReportDayCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(!cell){
        cell= [[ReportDayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
    Category *category =[self.objectCat objectAtIndex:indexPath.row];
    NSArray *listItemsFromCategory = [category.items allObjects];
    _amountAggregate = 0;
    
    if (listItemsFromCategory && [listItemsFromCategory count]) {
        //        NSData * currentdate= [[NSDate alloc] init];
        //        NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
        //
        //        [dateFormater setDateFormat:@"dd-MMM-yyy" ];
        //
        //        NSLog(@"prooverka e %@" ,dateFormater);
        
        
        
        
        for (Item *item in listItemsFromCategory) {
            
            NSDate * currentdate= [[NSDate alloc] init];
            
            /*  NSCalendar *calendar = [NSCalendar currentCalendar];
             NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:currentdate];
             NSInteger day = [components day];
             NSInteger month = [components month];
             */
            NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
            [dateFormater setDateFormat:@"dd-MMM-yyy" ];
            
            NSDateFormatter *dateFormater1 = [[NSDateFormatter alloc] init];
            [dateFormater1 setDateFormat:@"dd-MMM-yyy" ];
            
            NSString *currentD = [ dateFormater stringFromDate: currentdate];
            NSString *pickedD = [ dateFormater1 stringFromDate: item.date];
            NSLog(@"prooverka e %@ %@" ,currentD , pickedD);
            
            if([currentD isEqualToString:pickedD]){
                NSLog(@"start time is equal to date");
                
                _amountAggregate += [item.amount intValue];
                NSLog(@"prooverka e %d" ,_amountAggregate);
            }
            
            else {
                _amountAggregate =  _amountAggregate + 0;
                
            }
        }
        //            _amountAggregate += [item.amount intValue];
        //    }
    }
    cell.nameCategory.text=category.name;
    cell.categoryImage.image =[UIImage imageNamed:category.imageName];
    cell.vkupnoCell.text = [NSString stringWithFormat:@"%d", _amountAggregate];
    
    return cell;
}


//[_tableView reloadData];


//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    AddNewItemViewController *new = [[AddNewItemViewController alloc] init];
//   // [self presentViewController:new animated:YES completion:nil];
//    [self.navigationController pushViewController:new animated:YES];
//}




-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}



-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //  NSManagedObjectContext *context = [self managedObjectContext];
    
    if(editingStyle == UITableViewCellEditingStyleDelete){
        
        // [context deleteObject:[self.objectCat objectAtIndex:indexPath.row]];
        [[[AppDelegate instance] managedObjectContext] deleteObject:[self.objectCat objectAtIndex:indexPath.row]];
        
        /*   AppDelegate *del = (AppDelegate*) [UIApplication sharedApplication ];*/
        
        [[AppDelegate instance] saveContext ];
    }
    [self.objectCat removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    [self AmountAgregator];
    
}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"reportMonth"]){
       // ReportMonthViewController *destViewController = segue.destinationViewController;
        //     destViewController.delegate =self;
        
        
        //    } else
        //        if([segue.identifier isEqualToString:@"add"])
        //        {
        //            AddNewItemViewController *newItemController = segue.destinationViewController;
        //            NSIndexPath *index = [self.tableView indexPathForSelectedRow];
        //            newItemController.newobject =[_objectCat objectAtIndex:index.row];
        //        }
        //}
    }
}

-(void)AmountAgregator {
    _vkupno = 0;
    for (int n=0 ; n < [_objectCat count]; n++ ){
        _amountPom =0;
        Category *category = [self.objectCat objectAtIndex:n];
        NSArray *listItemsFromCategory = [category.items allObjects];
        if (listItemsFromCategory && [listItemsFromCategory count]) {
            
            for (Item *item in listItemsFromCategory) {
                
                _amountPom += [item.amount intValue];        }
        }
        _vkupno +=_amountPom;
        NSLog(@"vkupno e e %d" ,_vkupno);
        [_tableView reloadData];
        
    }
}



@end
