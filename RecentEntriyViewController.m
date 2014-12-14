//
//  RecentEntriyViewController.m
//  SidebarDemo
//
//  Created by Kireto on 9/1/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "RecentEntriyViewController.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "Item.h"
#import "Category.h"
#import "RecentEntityCell.h"
#import "AddItemViewController.h"
#import "Globals.h"
#import "CategoryPom.h"
#import "Profil.h"

@interface RecentEntriyViewController ()
//@property (nonatomic , strong) NSMutableArray *itemList;
@property (nonatomic , strong) NSMutableArray *categoryItem;
@property (nonatomic, strong ) NSArray *objectCat;
@property (nonatomic, strong ) NSArray *pomitemList;

@property (nonatomic , strong) NSMutableArray *itemList;


@end

@implementation RecentEntriyViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    __sidebarButton.target = self.revealViewController;
    __sidebarButton.action = @selector(revealToggle:);
    _expenseBtn.selected =YES;
    _incomeBtn.selected=NO;
    _profil = [Globals loadCurrentProfil];
    _categorypom = _profil.categoryProfil;
    self.objectCat = [_categorypom.expense allObjects];
    self.title =@"Recent Entry";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    _profil = [Globals loadCurrentProfil];
//    NSLog(@"Profilot e %@", _profil.description);
//
//    _categorypom = _profil.categoryProfil;
//    NSLog(@"Profilot e %@", _categorypom.description);
//
//    self.objectCat = [_categorypom.expense allObjects];
//    NSLog(@"Brojot na elementi vo objectCat e %lu" , (unsigned long)self.objectCat.count);
    
    if (!_itemList){
    _itemList = [[NSMutableArray alloc] init];
    }
    for (Category *cat in _objectCat){
        NSLog(@"Category e %@" , cat.name);
        NSLog(@"Category e %@" , cat.items.description);


       _pomitemList = [cat.items allObjects];
        NSLog(@"Brojot na elementi vo _pomitemList e %lu" , (unsigned long)_pomitemList.count);
        NSLog(@"Brojot na elementi vo ime _itemList list e  %lu" , (unsigned long)_itemList.count);
       
        for(Item *item in _pomitemList){
      
            [_itemList addObject:item];
        NSLog(@"Brojot na elementi vo ime _itemList list e  %lu" , (unsigned long)_itemList.count);
        }
     
    }
    NSLog(@"Brojot na elementi vo ime _itemList list e  %lu" , (unsigned long)_itemList.count);
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    [_itemList sortUsingDescriptors:[NSArray arrayWithObject:sort]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_itemList count];
}

- (RecentEntityCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellId = @"Cell";
    
    RecentEntityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(!cell){
     cell = [[RecentEntityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
    }
  
    
 

    
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"dd-MMM-yyy"];
    
    NSDateFormatter *dateFormaterTime = [[NSDateFormatter alloc] init];
    [dateFormaterTime setDateFormat:@"hh:mm a"];
//    if(_expenseBtn.selected){
//
//      //  self.objectCat = [_categorypom.expense allObjects];
//
//        for (Category *cat in _objectCat){
//            NSLog(@"Category e %@" , cat.name);
//            NSLog(@"Category e %@" , cat.items.description);
//            
//            
//            _pomitemList = [cat.items allObjects];
//            NSLog(@"Brojot na elementi vo _pomitemList e %lu" , (unsigned long)_pomitemList.count);
//            NSLog(@"Brojot na elementi vo ime _itemList list e  %lu" , (unsigned long)_itemList.count);
//            
//            for(Item *item in _pomitemList){
//                
//                [_itemList addObject:item];
//                NSLog(@"Brojot na elementi vo ime _itemList list e  %lu" , (unsigned long)_itemList.count);
//            }
//            
//        }
//
//    }
//    else if(_incomeBtn.selected){
//     //   self.objectCat = [_categorypom.income allObjects];
//        
//        for (Category *cat in _objectCat){
//            NSLog(@"Category e %@" , cat.name);
//            NSLog(@"Category e %@" , cat.items.description);
//            
//            
//            _pomitemList = [cat.items allObjects];
//            NSLog(@"Brojot na elementi vo _pomitemList e %lu" , (unsigned long)_pomitemList.count);
//            NSLog(@"Brojot na elementi vo ime _itemList list e  %lu" , (unsigned long)_itemList.count);
//            
//            for(Item *item in _pomitemList){
//                
//                [_itemList addObject:item];
//                NSLog(@"Brojot na elementi vo ime _itemList list e  %lu" , (unsigned long)_itemList.count);
//            }
//            
//        }
//        
//    }
    
    Item *item =[self.itemList objectAtIndex:indexPath.row];

    cell.DateLabel.text = [ dateFormater stringFromDate: item.date];
    cell.TimeLabel.text = [dateFormaterTime stringFromDate:item.date];
    cell.DescriptLabel.text =item.descript;
    cell.locationNameLabel.text=item.location;
    cell.CategoryLabel.text =item.categoryR.name;
   
    NSLog(@"%@", item.photoPath);

    cell.AmountLabel.text = [item.amount stringValue]; //convert nsnumber in string
    return cell;
}



- (IBAction)pressExpenseBtn:(id)sender {
    if (!_expenseBtn.selected) {
        
    self.objectCat = [_categorypom.expense allObjects];
        _itemList = [[NSMutableArray alloc] init];

        _incomeBtn.selected = NO;
        _expenseBtn.selected = YES;
        for (Category *cat in _objectCat){
            NSLog(@"Category e %@" , cat.name);
            NSLog(@"Category e %@" , cat.items.description);
            
            
            _pomitemList = [cat.items allObjects];
            NSLog(@"Brojot na elementi vo _pomitemList e %lu" , (unsigned long)_pomitemList.count);
            NSLog(@"Brojot na elementi vo ime _itemList list e  %lu" , (unsigned long)_itemList.count);
            
            for(Item *item in _pomitemList){
                
                [_itemList addObject:item];
                NSLog(@"Brojot na elementi vo ime _itemList list e  %lu" , (unsigned long)_itemList.count);
            }
            
        }
        [_tableView reloadData];
 }
}

- (IBAction)pressIncomeBtn:(id)sender {
    if (!_incomeBtn.selected) {
        _itemList = [[NSMutableArray alloc] init];
    self.objectCat = [_categorypom.income allObjects];
        _incomeBtn.selected = YES;
        _expenseBtn.selected = NO;
  
    for (Category *cat in _objectCat){
        NSLog(@"Category e %@" , cat.name);
        NSLog(@"Category e %@" , cat.items.description);
        
        
        _pomitemList = [cat.items allObjects];
        NSLog(@"Brojot na elementi vo _pomitemList e %lu" , (unsigned long)_pomitemList.count);
        NSLog(@"Brojot na elementi vo ime _itemList list e  %lu" , (unsigned long)_itemList.count);
        
        for(Item *item in _pomitemList){
            
            [_itemList addObject:item];
            NSLog(@"Brojot na elementi vo ime _itemList list e  %lu" , (unsigned long)_itemList.count);
        }
        [_tableView reloadData];

        
    }
    
}

}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [[AppDelegate instance] saveContext ];
    
    if(_expenseBtn.selected){
        
        // [context deleteObject:[self.objectCat objectAtIndex:indexPath.row]];
        [[[AppDelegate instance] managedObjectContext] deleteObject:[self.itemList objectAtIndex:indexPath.row]];
        
        /*   AppDelegate *del = (AppDelegate*) [UIApplication sharedApplication ];*/
        
        [[AppDelegate instance] saveContext ];
//ovde ne brisam od baza i toa kako da go napravam
        [self.itemList removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
}


    else {
        if(_incomeBtn.selected){
            
            // [context deleteObject:[self.objectCat objectAtIndex:indexPath.row]];
            [[[AppDelegate instance] managedObjectContext] deleteObject:[self.itemList objectAtIndex:indexPath.row]];
            
            /*   AppDelegate *del = (AppDelegate*) [UIApplication sharedApplication ];*/
            
            [[AppDelegate instance] saveContext ];
        
        [self.itemList removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
            }
        }
    }
}
    
    
    
    
    
    
    
    
    
    



@end
