//
//  MyLocationMapViewController.h
//  SidebarDemo
//
//  Created by Kireto on 9/24/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Protocol.h"
@interface MyLocationMapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate ,LocationNameProtocol>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property(nonatomic, retain) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
- (IBAction)tapForVenue:(id)sender;
@property (assign, nonatomic) BOOL pauseLocationUpdatesAutomatically;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) CLLocation * startLocation;
@property (weak, nonatomic) NSString *locationName;
@end
