 //
//  AddGroupeViewController.m
//  SidebarDemo
//
//  Created by TheMac on 11/13/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "AddGroupeViewController.h"
#import "SWRevealViewController.h"
#import "AddGroupeController.h"
#import "AddMemberController.h"
#import "AddExpenseViewController.h"
#import "ExpenseTableCell.h"
#import "Profil.h"
#import "Globals.h"
#import "CategoryPom.h"
#import "Groupe.h"
#import "Member.h"
#import "Expense.h"
#import "AppDelegate.h"
#import "DropDownListView.h"
#import "DebtsTableViewCell.h"
#import "Debts.h"

@interface AddGroupeViewController ()
@property NSArray *groupesArray;
@property NSArray *memberArray;
@property NSArray *expenseArray;
@property NSArray * arr;
@property NSArray * arrD;
@property BOOL selectedBtnpress ;


@property (nonatomic , strong) NSMutableArray *grArray;
@property (nonatomic , strong) NSMutableArray *memMutableArray;
@property (nonatomic , strong) NSMutableArray *pomosna;



@property (strong) NSArray *objectCat;
@end

@implementation AddGroupeViewController


- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (void)viewDidLoad {
  
    [super viewDidLoad];
  
    UIBarButtonItem *menu =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self.revealViewController action:@selector(revealToggle:)];
  //_selectedBtnpress =NO;
    self.navigationItem.leftBarButtonItem = menu;
    [_groupeDebtsBtn setSelected:YES];
    [_paymentBtn setSelected:NO];
    [_debtsBtn setSelected:NO];
    [_membersBtn setSelected:NO];

    [_groupeDebtsBtn setBackgroundImage:[UIImage imageNamed:@"btnSelectedBlue"] forState:UIControlStateSelected];
    [self.view addSubview:_groupeDebtsView];
    [self.expenseTableView registerNib:[UINib nibWithNibName:@"ExpenseTableCell" bundle:nil] forCellReuseIdentifier:@"CellExpense"];
    [self.debtsTableView registerNib:[UINib nibWithNibName:@"DebtsTableViewCell" bundle:nil] forCellReuseIdentifier:@"DebtsCell"];

    _profil = [Globals loadCurrentProfil];
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"nameGroupe" ascending:YES];
    
    _groupesArray=[_groupesArray sortedArrayUsingDescriptors:@[sort]];
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    _groupesArray = [_profil.profillGroups allObjects];
    _memberArray = [_profil.profilMember allObjects];

    NSLog(@"brojot na members vo profilot e %lu",(unsigned long)[_profil.profilMember count]);

    if(!_profil.profilMember.count){
        
        Member *mem = [NSEntityDescription insertNewObjectForEntityForName:@"Member" inManagedObjectContext:managedObjectContext];
        mem.name = _profil.nameP;
        mem.email = @"fdfdf";
        [_profil addProfilMemberObject:mem];
        Debts *deb = [NSEntityDescription insertNewObjectForEntityForName:@"Debts" inManagedObjectContext:managedObjectContext];
        deb.debtsMember =mem;
        
        _memberArray = [_profil.profilMember allObjects];
        
    }
    else{
        _memberArray = [_profil.profilMember allObjects];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    
    _groupesArray = [_profil.profillGroups allObjects];
    NSLog(@"brojot na krupi vo profilot e %lu",(unsigned long)[_groupesArray count]);
    NSLog(@"brojot na members vo profilot e %lu",(unsigned long)[_memberArray count]);

    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"nameGroupe" ascending:YES];
    _groupesArray=[_groupesArray sortedArrayUsingDescriptors:@[sort]];

    if(_groupeDebtsBtn.selected){
    [_groupesTableView reloadData];
    }
    else if(_membersBtn.selected){

    [_memberTableView reloadData];
}
    else if(_paymentBtn.selected){
        _grArray = [[NSMutableArray alloc] init];
        // }
        for (Groupe *gr in _groupesArray){
            NSLog(@"Groupe e %@" , gr.nameGroupe);
            NSLog(@"Category e %@" , gr.groupeExpense.description);
            
            
            _expenseArray = [gr.groupeExpense allObjects];
            NSLog(@"Brojot na elementi vo _expenseArray %lu" , (unsigned long)_expenseArray.count);
            // NSLog(@"Brojot na elementi vo ime _itemList list e  %lu" , (unsigned long)_itemList.count);
            
            for(Expense *ex in _expenseArray){
                [ex addExpenseMember:gr.groupeMembers];
                [_grArray addObject:ex];
                NSLog(@"Brojot na elementi vo _grArray  %lu" , (unsigned long)_grArray.count);
                NSLog(@"Brojot na members vo expense is  %lu" , (unsigned long)ex.expenseMember.count);

            }
            
        }
        
        _expenseArray =[_grArray copy];
        [_expenseTableView reloadData];
    }
    else if(_debtsBtn.selected){
        
        [_debtsTableView reloadData];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (IBAction)pressGroupeBtn:(id)sender {
    [_groupeDebtsBtn setSelected:YES];
    [_paymentBtn setSelected:NO];
    [_debtsBtn setSelected:NO];
    [_membersBtn setSelected:NO];

    [_groupeDebtsBtn setBackgroundImage:[UIImage imageNamed:@"btnSelectedBlue"] forState:UIControlStateSelected];
    [_groupesTableView reloadData];
  [self.view addSubview:_groupeDebtsView];
}

- (IBAction)pressPaymentBtn:(id)sender {
   
    [_groupeDebtsBtn setSelected:NO];
    [_paymentBtn setSelected:YES];
    [_debtsBtn setSelected:NO];
    [_membersBtn setSelected:NO];

    [_paymentBtn setBackgroundImage:[UIImage imageNamed:@"btnSelectedBlue"] forState:UIControlStateSelected];
   // if (!_grArray){
        _grArray = [[NSMutableArray alloc] init];
   // }
    for (Groupe *gr in _groupesArray){
        NSLog(@"Groupe e %@" , gr.nameGroupe);
        NSLog(@"Category e %@" , gr.groupeExpense.description);
        
        
        _expenseArray = [gr.groupeExpense allObjects];
        NSLog(@"Brojot na elementi vo _expenseArray %lu" , (unsigned long)_expenseArray.count);
       // NSLog(@"Brojot na elementi vo ime _itemList list e  %lu" , (unsigned long)_itemList.count);
        
        for(Expense *ex in _expenseArray){
            [ex addExpenseMember:gr.groupeMembers];
            [_grArray addObject:ex];
            NSLog(@"Brojot na elementi vo _grArray  %lu" , (unsigned long)_grArray.count);
            NSLog(@"Brojot na members vo expense is  %lu" , (unsigned long)ex.expenseMember.count);

        }
        
        
    }
    
    _expenseArray =[_grArray copy];
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    _expenseArray=[_expenseArray sortedArrayUsingDescriptors:@[sort]];
    
    [self.expenseTableView registerNib:[UINib nibWithNibName:@"ExpenseTableCell" bundle:nil] forCellReuseIdentifier:@"CellExpense"];
    [_expenseTableView reloadData];

   [self.view addSubview:_paymentView];

}

- (IBAction)pressDebtsBtn:(id)sender {
    
    [_groupeDebtsBtn setSelected:NO];
    [_paymentBtn setSelected:NO];
    [_debtsBtn setSelected:YES];
    [_membersBtn setSelected:NO];

    [_debtsBtn setBackgroundImage:[UIImage imageNamed:@"btnSelectedBlue"] forState:UIControlStateSelected];
    NSMutableArray *array= [[NSMutableArray alloc] init];
    for(Groupe *gr in _groupesArray){
        [array addObject:gr.nameGroupe];
    }
    arryList = [array copy];
    [_debtsTableView reloadData];
    [self.view addSubview:_debtsView];
    
    
}

- (IBAction)pressMembersBtn:(id)sender {
    [_groupeDebtsBtn setSelected:NO];
    [_paymentBtn setSelected:NO];
    [_debtsBtn setSelected:NO];
    [_membersBtn setSelected:YES];
    [_membersBtn setBackgroundImage:[UIImage imageNamed:@"btnSelectedBlue"] forState:UIControlStateSelected];
    
  
    
    [_memberTableView reloadData];
    [self.view addSubview:_membersView];
    

}
//-(NSInteger)numberOfSectionsInTable:(UITableView*)tableView{
//    if(_selectGroup.selected){
//    return  [_selectedGroup.groupeExpense count];
//    }
//    else return 0;
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    if(_selectGroup.selected){
//
//    return @"sec";
//    }
//    else return @"";
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(_groupeDebtsBtn.selected){
        _groupesArray=[_profil.profillGroups allObjects];

        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"nameGroupe" ascending:YES];
        _groupesArray=[_groupesArray sortedArrayUsingDescriptors:@[sort]];
        
        NSLog(@"Brojot na grupi vo profilot se  %lu" , (unsigned long)_groupesArray.count);

    return [_groupesArray  count];

    } else if (_membersBtn.selected){
        _memberArray= [_profil.profilMember allObjects];
        return [_memberArray count];
    }
    else if(_paymentBtn.selected){

        _grArray = [[NSMutableArray alloc] init];
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"nameGroupe" ascending:YES];
        _groupesArray=[_groupesArray sortedArrayUsingDescriptors:@[sort]];

        for (Groupe *gr in _groupesArray){
            NSLog(@"Groupe e %@" , gr.nameGroupe);
            NSLog(@"Category e %@" , gr.groupeExpense.description);
            
            
            _expenseArray = [gr.groupeExpense allObjects];
            NSLog(@"Brojot na elementi vo _pomitemList e %lu" , (unsigned long)_expenseArray.count);
            // NSLog(@"Brojot na elementi vo ime _itemList list e  %lu" , (unsigned long)_itemList.count);
            
            for(Expense *ex in _expenseArray){
                
                [_grArray addObject:ex];
                NSLog(@"Brojot na elementi vo ime _itemList list e  %lu" , (unsigned long)_grArray.count);
            }
        }
        _expenseArray=[_grArray copy];
        return [_expenseArray count];
        
    }
    else if(_debtsBtn.selected){
   //     if(!_selectedBtnpress){
            
            return  [_selectedGroup.groupeExpense count];
        NSLog(@"grupata sto e selektirana ima  %lu expense", (unsigned long)[_selectedGroup.groupeExpense count]);
  //  }
  //   else if(_selectedBtnpress){
  //       return 0;
  //   }
}
    return 0;
}


- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
    if ([segue.identifier isEqualToString: @"addGroupe"])
    {
    
        AddGroupeController *addGroupe = segue.destinationViewController;
        addGroupe.profil = _profil;
        
    }
    else if([segue.identifier isEqualToString: @"addMember"])
    {
        
        AddMemberController *addMember = segue.destinationViewController;
        addMember.profil = _profil;
        
    }
    else if([segue.identifier isEqualToString: @"addExpense"])
    {
        
        AddExpenseViewController *addExpense = segue.destinationViewController;
        NSLog(@"%@",addExpense.description);
        
    }
    
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    if(!_paymentBtn.selected && !_debtsBtn.selected){
      
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.textColor = [UIColor colorWithRed:109.0/255.0 green:120.0/255.0 blue:131.0/255.0 alpha:1.0];
            cell.textLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:17.0];
            cell.backgroundColor = [UIColor clearColor];
        }
        cell.textLabel.text=@"";
      
        if(_groupeDebtsBtn.selected){
        
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"nameGroupe" ascending:YES];
            _groupesArray=[_groupesArray sortedArrayUsingDescriptors:@[sort]];
            Groupe *gr = [_groupesArray objectAtIndex:indexPath.row ];
            cell.textLabel.text = gr.nameGroupe;
            NSLog(@"imeto na grupata e %@", gr.nameGroupe);
            NSLog(@"imeto na grupata e %lu", (unsigned long)gr.groupeMembers.count);

            
        }
        if(_membersBtn.selected){
          
            Member *mem = [_memberArray objectAtIndex:indexPath.row];
            cell.textLabel.text = mem.name;
        }
    
    }
    else if(_paymentBtn.selected || _debtsBtn.selected){
        if(_paymentBtn.selected){
            
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
            _expenseArray=[_expenseArray sortedArrayUsingDescriptors:@[sort]];
            
            [tableView registerNib:[UINib nibWithNibName:@"ExpenseTableCell" bundle:nil] forCellReuseIdentifier:@"CellExpense"];
            cell =[tableView dequeueReusableCellWithIdentifier:@"CellExpense"];
            cell.textLabel.text=@"";
            
            NSLog(@"brojot na elementi vo listata e %lu", (unsigned long)_expenseArray.count);
            
            
            Expense *ex =[_expenseArray objectAtIndex:indexPath.row];
            NSLog(@"Brojot na member in expense  e  %lul",(unsigned long)ex.expenseMember.count);

            
            ExpenseTableCell* theCell = (ExpenseTableCell*)cell;
            
            theCell.whoPaidLabel.text = [NSString stringWithFormat:@"%@ paid  %@  %@", ex.whopaid,[self checkCurrency:ex],[ex.amount stringValue]];
            theCell.forpaidLabel.text = @"All";
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init] ;
            [dateFormatter setDateFormat:@"dd-M-yy hh:mm"];
            theCell.dateLabel.text = [ dateFormatter stringFromDate:ex.date];
        }
   

    else if(_debtsBtn.selected){
       

        
        cell =[tableView dequeueReusableCellWithIdentifier:@"DebtsCell"];
        //  cell.textLabel.text=@"";
        cell.textLabel.text=@"";

        _arr = [_selectedGroup.groupeExpense allObjects];
        
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
        _arr=[_arr sortedArrayUsingDescriptors:@[sort]];
        
        NSLog(@"selektiranata grupa e %@",_selectedGroup.nameGroupe);
        _arrD=[_selectedGroup.groupeMembers allObjects];
        NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
        _arrD=[_arrD sortedArrayUsingDescriptors:@[sort1]];
        
        Expense *expense =[_arr objectAtIndex:indexPath.row];
        
        DebtsTableViewCell* theCell = (DebtsTableViewCell*)cell;
        NSString *whopaid;
        whopaid= expense.whopaid;
        float vrednost=[expense.amount floatValue];
        float numOfMem =[_selectedGroup.groupeMembers count];
        float valueFroMember = vrednost/numOfMem;
//                _arrD=[expense.expenseMember allObjects];
//                NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
//                _arrD=[_arrD sortedArrayUsingDescriptors:@[sort1]];

        NSLog(@" numOfMem e %f",(float)numOfMem);
        int y=0;
        NSArray *subview =[theCell.contentView subviews];
        for (UILabel* label in subview ) {
            [label removeFromSuperview];
        }

        for(Member *mem in _arrD){
            
            if([mem.name isEqualToString:whopaid]){
                NSString * valueForMemberString= [NSString stringWithFormat:@"%.00f",vrednost];
                UILabel *lblRef = [[UILabel alloc] initWithFrame:CGRectMake(10 , 0, 320 , 10)];
                [ lblRef setFont:[UIFont systemFontOfSize:10]];
                
                lblRef.adjustsFontSizeToFitWidth = TRUE;
                lblRef.adjustsLetterSpacingToFitWidth = TRUE;
               // [lblRef setTextAlignment:NSTextAlignmentCenter];
                lblRef.backgroundColor = [UIColor clearColor];
                lblRef.text = [NSString stringWithFormat:@"%@ paid %@ %@", whopaid,valueForMemberString,expense.currency];
                [theCell.contentView addSubview:lblRef];
                //float vkupno += vrednost;
                mem.paid  = expense.amount;
                NSLog(@"fdfd %@", mem.paid);
            }
            else{
                
                NSString * valueForMemberString= [NSString stringWithFormat:@"%.00f",valueFroMember];
                
                UILabel *lblRef = [[UILabel alloc] initWithFrame:CGRectMake(10 , y, 320 , 11)];
                [ lblRef setFont:[UIFont systemFontOfSize:10]];
                lblRef.adjustsFontSizeToFitWidth = TRUE;
                lblRef.adjustsLetterSpacingToFitWidth = TRUE;
               // [lblRef setTextAlignment:NSTextAlignmentCenter];
                lblRef.backgroundColor = [UIColor clearColor];
                lblRef.text = [NSString stringWithFormat:@"%@ ---->  %@  %@", mem.name, whopaid,valueForMemberString];
                [theCell.contentView addSubview:lblRef];
                y=y+11;
                mem.debt  = [NSNumber numberWithFloat:valueFroMember];
                NSLog(@"fdfd %@", mem.debt);

            }
            y=y+11;
            
            
        }
    }
 }
    return cell;
}

-(NSString *)checkCurrency:(Expense *)object{
    NSString *currency;
    if([object.currency isEqualToString:@"EUR"]){
         currency= @"€";
        
    }
    else if([object.currency isEqualToString:@"GBR"]){
        currency = @"£";
    }
    else if([object.currency isEqualToString:@"USD"]){
        currency= @"$";
    }
    else if([object.currency isEqualToString:@"MKD"]){
        currency = @"MKD";
    }
    return currency;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if(_groupeDebtsBtn.selected){
        
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"nameGroupe" ascending:YES];
        _groupesArray=[_groupesArray sortedArrayUsingDescriptors:@[sort]];
        _grExpense = [_groupesArray objectAtIndex:indexPath.row];

        NSLog(@"imeto na grupata e %@", _grExpense.nameGroupe);
        NSLog(@"imeto na grupata e %@", _grExpense.groupeMembers.description);


        NSString *cancelTitle = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? @"Cancel" : nil;
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Selec optios :"
                                                                 delegate:self
                                                        cancelButtonTitle:cancelTitle
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:
                                      @"Add expense",
                                      @"Cancel",
                               
                                      nil];
        // actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            // In this case the device is an iPad.
         //   [actionSheet showFromRect:[indexPath.row frame] inView:self.view animated:YES];
        }
        else{
            // In this case the device is an iPhone/iPod Touch.
            [actionSheet showInView:self.view];
        }
        
}
    else if(_paymentBtn.selected){
        
        NSLog(@"expense e %lu",(unsigned long)[_expenseArray count]);
        
        Expense *expense = [_expenseArray objectAtIndex:indexPath.row];
        NSLog(@"expense e %@",expense.descExpense);
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        
        AddExpenseViewController *addExpense = (AddExpenseViewController*) [storyboard instantiateViewControllerWithIdentifier:@"addExpense"];
        
        addExpense.expense=expense;
        addExpense.groupe=expense.groupeE;
        NSLog(@"grupata sto se praka e %@",expense.groupeE);

        [self.navigationController pushViewController:addExpense animated:YES];
        
    }

    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    if(buttonIndex == 0){
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];

        AddExpenseViewController *addExpense = (AddExpenseViewController*) [storyboard instantiateViewControllerWithIdentifier:@"addExpense"];
        
        addExpense.groupe= _grExpense;
        addExpense.nameProfil = _profil.nameP;
        
        NSLog(@"grupata sto se praka e %@",_grExpense.nameGroupe);
        NSLog(@"grupata sto se praka e %lu",(unsigned long)_grExpense.groupeMembers.count);

        [self.navigationController pushViewController:addExpense animated:YES];
    }
    [actionSheet dismissWithClickedButtonIndex:1 animated:YES];

}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    if(_groupeDebtsBtn.selected){
        
        NSLog(@"brojot na grupi vo profilot se %lu", (unsigned long)_groupesArray.count);
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"nameGroupe" ascending:YES];
        
        _groupesArray=[_groupesArray sortedArrayUsingDescriptors:@[sort]];
        Groupe *gr = [_groupesArray objectAtIndex:indexPath.row];

    if(editingStyle == UITableViewCellEditingStyleDelete){

        [[[AppDelegate instance] managedObjectContext] deleteObject:gr];
        [_profil removeProfillGroupsObject:gr];

        NSLog(@"brojot na grupi vo profilot se %@", [_groupesArray objectAtIndex:indexPath.row]);
        
       [[AppDelegate instance] saveContext ];
    }
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];

    }
    
    else if(_membersBtn.selected){
        
        NSLog(@"brojot na member vo profilot se %lu", (unsigned long)_memberArray.count);
//        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
//        _memberArray=[_memberArray sortedArrayUsingDescriptors:@[sort]];

        Member *mem = [_memberArray objectAtIndex:indexPath.row];
        
        if(editingStyle == UITableViewCellEditingStyleDelete){
            
            //    [[AppDelegate instance] saveContext ];
            [[[AppDelegate instance] managedObjectContext] deleteObject:mem];
            [_profil removeProfilMemberObject:mem];
            
            NSLog(@"memeberi vo profilot se %@", [_memberArray objectAtIndex:indexPath.row]);
            
            [[AppDelegate instance] saveContext ];
        }
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        
    }

    else if(_paymentBtn.selected){
        
        Expense *ex = [_expenseArray objectAtIndex:indexPath.row];
        NSLog(@"memeberi vo profilot se %lu", (unsigned long)_expenseArray.count);

        NSLog(@"memeberi vo profilot se %@", ex.descExpense);
        
        NSLog(@"memeberi vo profilot se %@", ex.groupeE.description);
        if(editingStyle == UITableViewCellEditingStyleDelete){
            
            //    [[AppDelegate instance] saveContext ];
            [[[AppDelegate instance] managedObjectContext] deleteObject:ex];
            [ex.groupeE removeGroupeExpenseObject:ex];
          
            
            [[AppDelegate instance] saveContext ];
        
        }
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationBottom];

    }
}



- (IBAction)pressSelectGroup:(id)sender {
    _selectGroup.selected=YES;
    [Dropobj fadeOut];
 //  if(!_selectedBtnpress){

    [self showPopUpWithTitle:@"Select group to view debts !" withOption:arryList xy:CGPointMake(16, 150) size:CGSizeMake(287, 280) isMultiple:NO];
//    }
//   else if(_selectedBtnpress){
//       [_debtsTableView reloadData];
////       [_debtsTableView clearsContextBeforeDrawing];
//       _selectedBtnpress=NO;
//       [self showPopUpWithTitle:@"Select group to view debts !" withOption:arryList xy:CGPointMake(16, 150) size:CGSizeMake(287, 280) isMultiple:NO];
//      // _selectedBtnpress =NO;
//       
//   }
}


-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple{
    
    
    Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:isMultiple];
    Dropobj.delegate = self;
    [Dropobj showInView:self.view animated:YES];
    
    /*----------------Set DropDown backGroundColor-----------------*/
    [Dropobj SetBackGroundDropDwon_R:0.0 G:108.0 B:194.0 alpha:0.70];
    
}
- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex{
    // ----------------Get Selected Value[Single selection]-----------------
    _selectGroup.titleLabel.text=[arryList objectAtIndex:anIndex];
    pom=[arryList objectAtIndex:anIndex];
    
    for(Groupe *gr in _groupesArray){
       if([gr.nameGroupe isEqualToString:pom])
           _selectedGroup = gr;
           }

    NSLog(@"grupata sto e selektirana e %@", _selectedGroup.nameGroupe);
    
    [_debtsTableView reloadData];
//   _selectGroup.selected =NO;
//   _pomosna = [[NSMutableArray alloc] init];
//   _arr = [_selectedGroup.groupeExpense allObjects];
//    _arrD=[_selectedGroup.groupeMembers allObjects];
//       float vkupnopaid = 0.0;
//       float vkupnodebts = 0.0;
//    
//    for(Expense *expense in _arr){
//
//        NSString *whopaid;
//        whopaid= expense.whopaid;
//        float vrednost=[expense.amount floatValue];
//        float numOfMem =[_selectedGroup.groupeMembers count];
//        float valueFroMember = vrednost/numOfMem;
//        
// 
//    for(Member *m in _arrD){
//        
//        if([expense.whopaid isEqualToString:m.name]){
//            vkupnopaid += vrednost;
//            m.memberDebts.paid = [NSNumber numberWithFloat:vrednost];
//            NSLog(@"grupata sto e selektirana e %@", m.memberDebts.paid);
//            [_pomosna addObject:m]
//        }
//        
//        else {
//            vkupnodebts+= valueFroMember;
//            m.memberDebts.debt= [NSNumber numberWithFloat:vkupnodebts];
//            NSLog(@"grupata sto e selektirana e %@ %f", m.memberDebts.debt,numOfMem);
//
//        }
//    }
//    
//    [_debtsTableView reloadData];
//    NSLog(@"grupata sto e selektirana e %@", _selectedGroup.nameGroupe);
//     //vo pom go stavam imeto na grupata koja sto e selektirana
//}*/
}


@end
