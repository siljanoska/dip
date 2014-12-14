//
//  MyLocationMapViewController.m
//  SidebarDemo
//
//  Created by Kireto on 9/24/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "MyLocationMapViewController.h"
#import "AFNetworking.h"
#import "NSDictionary+VenueD.h"
#import "ShowLocation.h"
@interface MyLocationMapViewController ()

@end

@implementation MyLocationMapViewController

@synthesize mapView;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mapView.delegate =self;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.delegate = self;
    if ([[[UIDevice currentDevice] systemVersion]floatValue]>= 8.0) {
    
            [self.locationManager requestWhenInUseAuthorization];
      //  [self.locationManager requestAlwaysAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];
    self.pauseLocationUpdatesAutomatically = YES;
    
    mapView.showsUserLocation = YES;
   /* [mapView setMapType:MKMapTypeStandard];
    [mapView setZoomEnabled:YES];
    [mapView setScrollEnabled:YES];*/
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)locationName:(NSString *)name{
    _locationName = name;
    //_longitudeLabel.text= _locationName;
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 1000, 1000);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init ];
    
    point.coordinate =userLocation.coordinate;
    point.title= @"Where am I ?";
    point.subtitle=@"I`m here";
    [self.mapView addAnnotation:point];
    _startLocation = nil;
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"didFailWithError :%@" ,error);
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to get your location!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}
-(void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    NSLog(@"didUpdateToLocation %@", newLocation);
    if(_startLocation == nil){
  //  CLLocation *currentLocation = newLocation;
        _startLocation = newLocation;
  //  if(currentLocation != nil){
//        _longitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
//        _latitudeLabel.text =[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        _longitudeLabel.text = [NSString stringWithFormat:@"%.8f", _startLocation.coordinate.longitude];
        _latitudeLabel.text =[NSString stringWithFormat:@"%.8f", _startLocation.coordinate.latitude];

    //}
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showlocation"])
    {
        ShowLocation * showlocation = segue.destinationViewController;
        showlocation.delegateLocationName =self;
    }

}


- (IBAction)tapForVenue:(id)sender {
   /*
  
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:BaseURLString]];
    [manager GET:@"weather.php?format=json"
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             self.weather = (NSDictionary *)responseObject;
             self.title=@"JSON Retrieved";
             [self.tableView reloadData];
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                                 message:[error localizedDescription]
                                                                delegate:nil
                                                       cancelButtonTitle:@"Ok"
                                                       otherButtonTitles:nil];
             [alertView show];
         }];*/

}
@end
