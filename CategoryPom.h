//
//  CategoryPom.h
//  SidebarDemo
//
//  Created by TheMac on 12/11/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Category;

@interface CategoryPom : NSManagedObject

@property (nonatomic, retain) NSSet *expense;
@property (nonatomic, retain) NSSet *income;
@end

@interface CategoryPom (CoreDataGeneratedAccessors)

- (void)addExpenseObject:(Category *)value;
- (void)removeExpenseObject:(Category *)value;
- (void)addExpense:(NSSet *)values;
- (void)removeExpense:(NSSet *)values;

- (void)addIncomeObject:(Category *)value;
- (void)removeIncomeObject:(Category *)value;
- (void)addIncome:(NSSet *)values;
- (void)removeIncome:(NSSet *)values;

@end
