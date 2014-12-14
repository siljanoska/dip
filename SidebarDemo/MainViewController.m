    
//
//  ViewController.m
//  SidebarDemo
//
//  Created by Simon on 28/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "AddCategory.h"
#import "AddItemViewController.h"
#import "AddNewItemViewController.h"
#import "AppDelegate.h"
#import "MainTableViewCell.h"
#import "Category.h"
#import "CategoryPom.h"
#import "Item.h"
#import "Profil.h"
#import "Globals.h"
#import <FacebookSDK/FacebookSDK.h>

@interface MainViewController ()

@property (strong) NSArray *objectCat;
@property (strong) NSArray *objecProfil;
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
        _expenseBtn.selected = YES;
        _sidebarButton.target = self.revealViewController;
        _sidebarButton.action = @selector(revealToggle:);
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    _profil = [Globals loadCurrentProfil];
    NSLog(@"objectProfil list e %@",_profil.description);
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"CategoryPom"];
    NSArray *objectCatPom = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];

    if([objectCatPom  count]){
        BOOL exist = NO;
      for (CategoryPom * pom in objectCatPom) {
        
          if(_profil.categoryProfil == pom){

        _categorypom = _profil.categoryProfil;
        NSLog(@"objectProfil list e %@",_profil.categoryProfil.description);
              exist =YES;
              break;

          }
      }
        if(!exist){
               _categorypom = [NSEntityDescription insertNewObjectForEntityForName:@"CategoryPom" inManagedObjectContext:managedObjectContext];
               _profil.categoryProfil = _categorypom;
               NSLog(@"objectProfil list e %@",_profil.description);
        }
    }
    else {
                
    

        _categorypom = [NSEntityDescription insertNewObjectForEntityForName:@"CategoryPom" inManagedObjectContext:managedObjectContext];
        _profil.categoryProfil = _categorypom;
        NSLog(@"objectProfil list e %@",_profil.description);
        
        
    }
    
        self.objectCat = [_categorypom.expense allObjects];
        _totalExpense =[self amountAgregatorTotal:self.objectCat = [_categorypom.expense allObjects]];
        _totalLabelExpense.text = [NSString stringWithFormat:@"%d", _totalExpense];
        _totalIncome =[self amountAgregatorTotal:self.objectCat = [_categorypom.income allObjects]];
        _totalLabelIncome.text = [NSString stringWithFormat:@"%d", _totalIncome];
        _saldo = (_totalIncome - _totalExpense);
        NSLog(@"saldoto e %d, %d ", _totalIncome , _totalExpense);
        _saldoLabel.text = [NSString stringWithFormat:@"%d", _saldo];
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
       _objectCat=[_objectCat sortedArrayUsingDescriptors:@[sort]];
      //  [Globals saveCurrentProfil:_profil];
       NSLog(@"profilot e %@", [Globals loadCurrentProfil]);
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(_expenseBtn.selected){
        
        self.objectCat = [_categorypom.expense allObjects];
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
        _objectCat=[_objectCat sortedArrayUsingDescriptors:@[sort]];

     }
    else {
        self.objectCat = [_categorypom.income allObjects];
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
        _objectCat=[_objectCat sortedArrayUsingDescriptors:@[sort]];

               }
      [self.tableView reloadData];
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return [_objectCat count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
        return 1;
}

- (MainTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
       NSString *cellId = @"Cell";
       MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
       Category *category =[self.objectCat objectAtIndex:indexPath.row];
    
    if(_expenseBtn.selected){
       
        _amountAggregate = [self amountAgregatorItemInCategory:category];
        _totalExpense =[self amountAgregatorTotal:self.objectCat];
        _totalLabelExpense.text = [NSString stringWithFormat:@"%d", _totalExpense];
        _saldo = (_totalIncome - _totalExpense);
        _saldoLabel.text = [NSString stringWithFormat:@"%d", _saldo];
        
    }
    else {
        
        if(_incomeBtn.selected){
        _amountAggregate = [self amountAgregatorItemInCategory:category];
        _totalIncome =[self amountAgregatorTotal:self.objectCat];
        _totalLabelIncome.text = [NSString stringWithFormat:@"%d", _totalIncome];
        _saldo = (_totalIncome - _totalExpense);
        _saldoLabel.text = [NSString stringWithFormat:@"%d", _saldo];
        }
    }
        cell.nameCategory.text=category.name;
        cell.categoryImage.image =[UIImage imageNamed:category.imageName];
        cell.vkupnoCell.text = [NSString stringWithFormat:@"%d", _amountAggregate];
        [cell.vkupnoCell sizeToFit];
        [cell.nameCategory sizeToFit];
        [_totalLabelExpense sizeToFit];
        [_totalLabelIncome sizeToFit];
        return cell;
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
        return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(editingStyle == UITableViewCellEditingStyleDelete){
       // [context deleteObject:[self.objectCat objectAtIndex:indexPath.row]];
       // AppDelegate *del = (AppDelegate*) [UIApplication sharedApplication ];
        [[AppDelegate instance] saveContext ];
    }
    if(_expenseBtn.selected){
    
        Category *cat = [_objectCat objectAtIndex:indexPath.row];
            // biram vo koja kategorija sakam da go stavam    [_categorypom remo]
        [_categorypom removeExpenseObject:cat ];
        [[[AppDelegate instance] managedObjectContext] deleteObject:[self.objectCat objectAtIndex:indexPath.row]];
        self.objectCat = [_categorypom.expense allObjects];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        _totalExpense =[self amountAgregatorTotal:self.objectCat];
        _totalLabelExpense.text = [NSString stringWithFormat:@"%d", _totalExpense];
        _saldo = _totalIncome - _totalExpense;
        _saldoLabel.text=[NSString stringWithFormat:@"%d",_saldo];
    }
    else {
        if(_incomeBtn.selected){
            
        Category *cat = [_objectCat objectAtIndex:indexPath.row];
        NSLog(@"objektot sto se brisi e %@", cat.description);
        // biram vo koja kategorija sakam da go stavam    [_categorypom remo]
        // [self.objectCat removeObjectAtIndex:indexPath.row];
        [_categorypom removeIncomeObject:cat ];
        [[[AppDelegate instance] managedObjectContext] deleteObject:[self.objectCat objectAtIndex:indexPath.row]];
        self.objectCat = [_categorypom.income allObjects];
           _totalIncome =[self amountAgregatorTotal:self.objectCat];
           _totalLabelIncome.text = [NSString stringWithFormat:@"%d", _totalIncome];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        }
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    if([segue.identifier isEqualToString:@"addNewCategory"]){
    
       if(_expenseBtn.selected){
  
        AddItemViewController *destViewController = segue.destinationViewController;
        destViewController.flag = 1;
        destViewController.categoryPom = _categorypom;
        NSLog(@"profil %@",_profil.nameP);
    }
    else
        if(_incomeBtn.selected){
       
        AddItemViewController *destViewController = segue.destinationViewController;
        destViewController.flag = 0;
        destViewController.categoryPom = _categorypom;
    }
    
} else
    
    if([segue.identifier isEqualToString:@"addNewItem"])
        {
        AddNewItemViewController *newItemImCategory =segue.destinationViewController;
        NSIndexPath *index = [self.tableView indexPathForSelectedRow];
        newItemImCategory.newobject = [_objectCat objectAtIndex:index.row];
            newItemImCategory.flag = 1;

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
////treba da napravam eden metod so koj ke go povikuvam i ke mi presmetuva vkupna vrednost po site kategorii
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

- (IBAction)pressIncomeButton:(id)sender {
   
    if (!_incomeBtn.selected) {
        
        self.objectCat = [_categorypom.income allObjects];
        _incomeBtn.selected = YES;
        _expenseBtn.selected = NO;
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
        _objectCat=[_objectCat sortedArrayUsingDescriptors:@[sort]];

        [_tableView reloadData];
    }
}
- (IBAction)pressExpenseButton:(id)sender {
    
    if (!_expenseBtn.selected) {

        self.objectCat = [_categorypom.expense allObjects];
        _incomeBtn.selected = NO;
        _expenseBtn.selected = YES;
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
        _objectCat=[_objectCat sortedArrayUsingDescriptors:@[sort]];

        [_tableView reloadData];

    
    }
    
}
@end
