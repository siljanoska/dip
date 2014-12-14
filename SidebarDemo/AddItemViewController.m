//
//  AddItemViewController.m
//  SidebarDemo
//
//  Created by Kireto on 8/19/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//
//#import <CoreData/CoreData.h>
#import "AddItemViewController.h"
#import "AddCategory.h"
#import "MainViewController.h"
#import "Cell.h"
#import "Category.h"
#import "CategoryPom.h"
#import "Profil.h"

@interface AddItemViewController ()

@property NSString * selectedPhoto;
@end

@implementation AddItemViewController



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
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    // Do any additional setup after loading the view.
    _imageCategory =[NSArray arrayWithObjects:@"slika1",@"slika2",@"slika3",@"slika4",@"slika5",@"slika6",@"slika6", @"slika8",@"slika9",@"slika10",@"slika11",@"slika12", @"slika13",@"slika14",@"slika15",nil];
    _imageView.image = [UIImage imageNamed:@"slika1"];
    _selectedPhoto =@"slika1";
      [self.collectionView registerClass:[Cell class] forCellWithReuseIdentifier:@"cell"];
    
    


}
-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"koi profili postojat %@",_profilC.description);
}

-(NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context =nil;
    id delegate =[[UIApplication sharedApplication ]delegate];
    if([delegate performSelector:@selector(managedObjectContext)]){
        context = [delegate managedObjectContext];
    }
    return  context;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewContro   				ller].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)pressSaveItemBtn:(id)sender {
    if([_textField.text length]) {
        
        if(_flag==1){
            NSManagedObjectContext *context = [self managedObjectContext];
            Category *newc = [NSEntityDescription insertNewObjectForEntityForName:@"Category" inManagedObjectContext:context];
          //  Profil *prof = [NSEntityDescription insertNewObjectForEntityForName:@"Profil" inManagedObjectContext:context];
            newc.name = self.textField.text;
            newc.imageName = _selectedPhoto;
           // NSLog(@"Profilot e %@",prof);
            [_categoryPom addExpenseObject:newc];
          //  [_profilC addCategoryPObject :newc];
            
            NSError *error = nil;
            
            if (![context save:&error]) {
                
                NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                
            }
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        else {
            if(_flag==0){
                NSManagedObjectContext *context = [self managedObjectContext];
                Category *newc = [NSEntityDescription insertNewObjectForEntityForName:@"Category" inManagedObjectContext:context];
                newc.name = self.textField.text;
                newc.imageName = _selectedPhoto;
                [_categoryPom addIncomeObject:newc];
                
                NSError *error = nil;
                
                if (![context save:&error]) {
                    
                    NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                    
                }
                
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }
    else
    {
        
        UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"error" message:@"Please insert code" delegate:nil cancelButtonTitle:@"Dissmiss" otherButtonTitles:nil];
        [alertView show];
    }


}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches ]anyObject]  ;
    if(![[touch view] isKindOfClass:[UITextField class]]){
        [self.view endEditing:YES];
    }
    [super touchesBegan:touches withEvent:event];
}


-(NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_imageCategory count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * identifire =@"cell";
    
  Cell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:identifire forIndexPath:indexPath];
    
  cell.imageCell.image =[UIImage imageNamed:[_imageCategory objectAtIndex:indexPath.row]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    _selectedPhoto = [_imageCategory objectAtIndex:indexPath.row];
    _imageView.image = [UIImage imageNamed:_selectedPhoto];
    
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
}
@end
