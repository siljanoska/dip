//
//  NSDictionary+venue.m
//  SidebarDemo
//
//  Created by Kireto on 10/6/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "NSDictionary+venue.h"

@implementation NSDictionary (venue)
-(NSString *)nameVenues {
    NSString *name =self[@"name"];
    return name;
}
-(NSInteger )metacode {
    NSNumber *code =self[@"code"];
    return [code integerValue];
}
@end
