//
//  Expense.h
//  SidebarDemo
//
//  Created by TheMac on 12/11/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Groupe, Member;

@interface Expense : NSManagedObject

@property (nonatomic, retain) NSNumber * amount;
@property (nonatomic, retain) NSString * currency;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * descExpense;
@property (nonatomic, retain) NSNumber * numOfmembers;
@property (nonatomic, retain) NSString * whopaid;
@property (nonatomic, retain) Groupe *groupeE;
@property (nonatomic, retain) NSSet *expenseMember;
@end

@interface Expense (CoreDataGeneratedAccessors)

- (void)addExpenseMemberObject:(Member *)value;
- (void)removeExpenseMemberObject:(Member *)value;
- (void)addExpenseMember:(NSSet *)values;
- (void)removeExpenseMember:(NSSet *)values;

@end
