//
//  Debts.h
//  SidebarDemo
//
//  Created by TheMac on 12/11/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Member;

@interface Debts : NSManagedObject

@property (nonatomic, retain) NSNumber * debt;
@property (nonatomic, retain) NSNumber * paid;
@property (nonatomic, retain) Member *debtsMember;

@end
