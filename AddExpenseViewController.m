//
//  AddExpenseViewController.m
//  SidebarDemo
//
//  Created by TheMac on 11/20/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "AddExpenseViewController.h"
#import "Groupe.h"
#import "Member.h"
#import "Expense.h"
#import "AppDelegate.h"
#import "DropDownListView.h"


@interface AddExpenseViewController ()

@property (strong) NSArray *expenseArray;
@property (strong) NSArray *memberArray;
@property (strong) NSMutableArray *pom;


@property BOOL exist;
@end

@implementation AddExpenseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _nameOfGropueTextField.text =_groupe.nameGroupe;
    _expenseArray = [_groupe.groupeExpense allObjects];
    _memberArray = [_groupe.groupeMembers allObjects];
    _pom = [[NSMutableArray alloc] init];

    for(Member *m in _memberArray){
        
        [_pom addObject:m.name];
    }
    arryList =[_pom copy];
    
    if([_expenseArray containsObject:_expense ]){
  
        NSLog(@"postoi objektot");
        _amountTextField.text=[NSString stringWithFormat:@"%@", _expense.amount];
        _whopaidTextField.text=_expense.whopaid;
        float vrednost=[_expense.amount floatValue];
        float numOfMem =[_groupe.groupeMembers count];
        NSLog(@" numOfMem e %f",(float)numOfMem);

        float valueFroMember = vrednost/numOfMem;
        NSLog(@" valueFroMember e %f",(float)valueFroMember);

        [self drawTextField: valueFroMember];
        _exist = YES;
    }
    else
    {
        NSLog(@"objektot ne postoi");
        
        _amountTextField.text=@"";
        _amountTextField.placeholder=@"Insert amount";
        float vrednost=0;//[_expense.amount floatValue];
        [self drawTextField:vrednost];
        _exist = NO;

    }
    
    NSString *string1 =@" ";
    int i= 0;
    NSLog(@"_groupe.groupeMembers %@",_groupe.nameGroupe);
    NSLog(@"_groupe.groupeMembers %lu",(unsigned long)_groupe.groupeMembers.count);
        for(Member *mem in _groupe.groupeMembers){
        
              string1 = [string1 stringByAppendingString:mem.name];
        if(i<[_groupe.groupeMembers count]-1)
        {
            string1 = [string1 stringByAppendingString:@","];
            i++;
        }
        else{
            string1 = [string1 stringByAppendingString:@" "];
            
        }
        NSLog(@"stringot e %@", string1);
        //_membersOfGroupe.text = mem.name;
        
    }
    _membersOfGroupe.text = string1;
    _whopaidTextField.placeholder = @"Tap to add who paid";

}
-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"members na grupata se %@",_groupe.groupeMembers.description);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)drawTextField :(float)valueFroMember{
    NSString *string1 =@" ";
    int i= 0;
    NSLog(@"_groupe.groupeMembers %@",_groupe.nameGroupe);
    NSLog(@"_groupe.groupeMembers %lu",(unsigned long)_groupe.groupeMembers.count);
    int y=300;
  //  int x1= 200;
    int x2=190;
    int width=180;
 //   int width1=30;
    int width2=120;
    
    
    int height =30;
    for(Member *mem in _groupe.groupeMembers){
        
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(10, y, width, height)];
     //   UITextField * textFieldQ = [[UITextField alloc] initWithFrame:CGRectMake(x1, y, width1, height)];
        _textFieldQuanty = [[UITextField alloc] initWithFrame:CGRectMake(x2, y, width2, height)];
        
        textField.text = mem.name;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.font = [UIFont systemFontOfSize:15];
        textField.placeholder = @"enter text";
        textField.backgroundColor= [UIColor redColor];
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        textField.keyboardType = UIKeyboardTypeDefault;
        textField.returnKeyType = UIReturnKeyDone;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textField.delegate = self;

        
        _textFieldQuanty.text=[NSString stringWithFormat:@"%.02f", valueFroMember];
        _textFieldQuanty.font = [UIFont systemFontOfSize:10];
        
        [self.view addSubview:textField];
        [self.view addSubview:_textFieldQuanty];
        _textFieldQuanty.borderStyle = UITextBorderStyleRoundedRect;
        
        _textFieldQuanty.enabled =NO;
        textField.enabled=NO;
        
        string1 = [string1 stringByAppendingString:mem.name];
        if(i<[_groupe.groupeMembers count]-1)
        {
            string1 = [string1 stringByAppendingString:@","];
            i++;
        }
        else{
            string1 = [string1 stringByAppendingString:@" "];
            
        }
        NSLog(@"stringot e %@", string1);

        y=y+height;
        
    }
    NSLog(@"value e %@",_amountTextField.text);
    // Do any additional setup after loading the view.

    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if (![[touch view] isKindOfClass:[UITextField class]])
    {
        [self.view endEditing:YES];
        [Dropobj fadeOut];

    }
    [self textFieldDidEndEditing:_amountTextField];

    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    float value = [ _amountTextField.text floatValue];
    float numOfMem =[_groupe.groupeMembers count];
    float valueFroMember = value/numOfMem;
    [self drawTextField: valueFroMember];

}

-(NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context =nil;
    id delegate =[[UIApplication sharedApplication ]delegate];
    if([delegate performSelector:@selector(managedObjectContext)])
    {
        context = [delegate managedObjectContext];
    }
    return  context;
    
}

- (IBAction)pressSaveBtn:(id)sender {
    
    if([_amountTextField.text length]&& [_whopaidTextField.text length])
    {
        if(!_exist){
        NSManagedObjectContext *context= [self managedObjectContext];

        Expense *newexpense=[NSEntityDescription insertNewObjectForEntityForName:@"Expense" inManagedObjectContext:context];
        
        newexpense.whopaid=_whopaidTextField.text;
        newexpense.descExpense = _nameProfil ;
        newexpense.currency = _groupe.currency;
        NSLog(@"amount e %@",_amountTextField.text);
        NSNumber *newNum = [NSNumber numberWithLong:[_amountTextField.text longLongValue]];
        newexpense.amount = [NSNumber numberWithLong:[_amountTextField.text longLongValue]];
        NSLog(@"newExpense.amount %ld,%ld",[newexpense.amount longValue], [newNum longValue]);
        
        newexpense.numOfmembers =[NSNumber numberWithInteger:_groupe.groupeMembers.count];
        NSLog(@"newexpense.numOfmembers  %@l",newexpense.numOfmembers);

        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init] ;
        NSDate *currentdate= [NSDate date];
        [dateFormatter setDateFormat:@"dd-M-yy hh:mm"];

        newexpense.date= currentdate;
            
        [_groupe addGroupeExpenseObject:newexpense];
            // ne e kreiran kako ke go dadodades
        NSLog(@"Brojot na member in groupe  e  %lul",(unsigned long)_groupe.groupeMembers.count);
            
        NSLog(@"Brojot na member in expense  e  %lul",(unsigned long)_expense.expenseMember.count);
        NSLog(@"Grupata e  %@l",_groupe.nameGroupe);
        NSError *error = nil;
        
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    
    }
    else if(_exist){
 
        if([_amountTextField.text isEqualToString:[_expense.amount stringValue]] && [_whopaidTextField.text isEqualToString:_expense.whopaid]){
      
      //  _expense.amount = [NSNumber numberWithLong:[_amountTextField.text longLongValue]];
        
        NSLog(@"Objektot e veke snimen  %@l",_expense.numOfmembers);
            UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"!!" message:@"Nema promeni vo expense! " delegate:nil cancelButtonTitle:@"Cancle" otherButtonTitles:nil];
            alertView.tag=100;
            [alertView show];
        }
        else
        {
            //trebaa da go izbrisam pa da go presnimam na novo ili nekako izmeni da napravam
        _expense.amount = [NSNumber numberWithLong:[_amountTextField.text longLongValue]];
        _expense.whopaid = _whopaidTextField.text;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init] ;
        NSDate *currentdate= [NSDate date];
        [dateFormatter setDateFormat:@"dd-M-yy hh:mm"];
        
        _expense.date= currentdate;
        
        [[AppDelegate instance] saveContext ];

       // [_groupe addGroupeExpenseObject:_expense];
            }
    }

    }
    else {
        UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"Error " message:@"Please insert amount ! " delegate:nil cancelButtonTitle:@"Dissmiss" otherButtonTitles:nil];
        [alertView show];
    }

    [self.navigationController popViewControllerAnimated:YES];
}
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 100) {
        if (buttonIndex==0){
            [self.navigationController popViewControllerAnimated:YES];

        }

}

}
- (IBAction)pressWhoPaidButton:(id)sender {
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"Select Who paid" withOption:arryList xy:CGPointMake(16, 150) size:CGSizeMake(287, 280) isMultiple:NO];

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
    _whopaidTextField.text=[arryList objectAtIndex:anIndex];
}




@end
