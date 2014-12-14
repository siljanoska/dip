//
//  Venue.h
//  SidebarDemo
//
//  Created by Kireto on 10/2/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Venue : NSObject

@property (nonatomic , assign) NSString *vanueName;
@property (nonatomic, assign)  NSString *address;
@property (nonatomic ,assign)  NSString *city;
@property (nonatomic , assign) NSString *country;

@property (nonatomic,assign) double longitude;
@property (nonatomic,assign) double latitude;

//-(id) initWithDictionary:(NSDictionary *)dictionary;
@end
