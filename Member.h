//
//  Member.h
//  SidebarDemo
//
//  Created by TheMac on 12/11/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Debts, Expense, Groupe, Profil;

@interface Member : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * paid;
@property (nonatomic, retain) NSNumber * debt;
@property (nonatomic, retain) Debts *memberDebts;
@property (nonatomic, retain) NSSet *memberGroupe;
@property (nonatomic, retain) Profil *memberProfil;
@property (nonatomic, retain) Expense *memberExpense;
@end

@interface Member (CoreDataGeneratedAccessors)

- (void)addMemberGroupeObject:(Groupe *)value;
- (void)removeMemberGroupeObject:(Groupe *)value;
- (void)addMemberGroupe:(NSSet *)values;
- (void)removeMemberGroupe:(NSSet *)values;

@end
