//
//  Groupe.h
//  SidebarDemo
//
//  Created by TheMac on 12/11/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Expense, Member, Profil;

@interface Groupe : NSManagedObject

@property (nonatomic, retain) NSString * currency;
@property (nonatomic, retain) NSString * nameGroupe;
@property (nonatomic, retain) NSSet *groupeExpense;
@property (nonatomic, retain) NSSet *groupeMembers;
@property (nonatomic, retain) Profil *groupeP;
@end

@interface Groupe (CoreDataGeneratedAccessors)

- (void)addGroupeExpenseObject:(Expense *)value;
- (void)removeGroupeExpenseObject:(Expense *)value;
- (void)addGroupeExpense:(NSSet *)values;
- (void)removeGroupeExpense:(NSSet *)values;

- (void)addGroupeMembersObject:(Member *)value;
- (void)removeGroupeMembersObject:(Member *)value;
- (void)addGroupeMembers:(NSSet *)values;
- (void)removeGroupeMembers:(NSSet *)values;

@end
