//
//  MembersViewController.m
//  SidebarDemo
//
//  Created by TheMac on 11/24/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "MembersViewController.h"
#import "Member.h"
#import "Groupe.h"
#import "Globals.h"
#import "Profil.h"
@interface MembersViewController ()
@property NSArray *memberArray;
@property NSMutableArray *selectedCells;

@end

@implementation MembersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _profil = [Globals loadCurrentProfil];
    _memberArray = [_profil.profilMember allObjects];
    _selectedCells = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return [_memberArray count];
    
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor colorWithRed:109.0/255.0 green:120.0/255.0 blue:131.0/255.0 alpha:1.0];
        cell.textLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:17.0];
        cell.backgroundColor = [UIColor clearColor];
        
        Member *mem = [_memberArray objectAtIndex:indexPath.row];
        if([mem.name isEqualToString:_profil.nameP]){
            cell.accessoryType= UITableViewCellAccessoryCheckmark;
            [_selectedCells addObject:mem];
        
        }
        cell.textLabel.text = mem.name;
        
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    {
        UITableViewCell *theSelectedCell = [tableView cellForRowAtIndexPath:indexPath];
        theSelectedCell.accessoryType= UITableViewCellAccessoryCheckmark;

        Member *mem = [_memberArray objectAtIndex:indexPath.row];
        self.tableView.allowsMultipleSelection = YES;

            [_selectedCells addObject:mem];

        NSLog(@"listata g sodrzi slednive elementi %@", mem.description);
        NSLog(@"listata g sodrzi slednive elementi %lu", (unsigned long)_selectedCells.count);
        
    }
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;

    Member *mem = [_memberArray objectAtIndex:indexPath.row];

    [_selectedCells removeObject:mem];
    NSLog(@"listata g sodrzi slednive elementi %lu", (unsigned long)_selectedCells.count);

}


- (IBAction)pressSaveBtn:(id)sender {
    NSArray *selectedCellArray = [[NSArray alloc] init];
   // Member *mem = []
    selectedCellArray = [_selectedCells copy];
    [self.delegateArrayOfMembersInGroupe arrayOfMembersInGroupe:selectedCellArray];

    [self.navigationController popViewControllerAnimated:YES];
}



@end
