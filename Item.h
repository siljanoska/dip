//
//  Item.h
//  SidebarDemo
//
//  Created by TheMac on 12/11/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Category;

@interface Item : NSManagedObject

@property (nonatomic, retain) NSNumber * amount;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * descript;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * paymentMethod;
@property (nonatomic, retain) NSString * photoPath;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) Category *categoryR;

@end
