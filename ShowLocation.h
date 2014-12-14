//
//  ShowLocation.h
//  SidebarDemo
//
//  Created by Kireto on 10/2/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPClient.h"
#import "Protocol.h"

@interface ShowLocation : UIViewController <CLLocationManagerDelegate ,HTTPClientDelegate>
@property (nonatomic , weak) id<LocationNameProtocol>delegateLocationName;
@property (nonatomic , strong) CLLocationManager *locationManager;
@property(strong) NSDictionary *venues;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *venue;
@property (nonatomic, assign) NSInteger numberOfVenues;

@property (nonatomic , strong) NSString * locationName;
@end
