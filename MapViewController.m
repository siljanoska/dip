//
//  MapViewController.m
//  SidebarDemo
//
//  Created by Kireto on 9/24/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "MapViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface MapViewController ()

@end

@implementation MapViewController {
    
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
 //   CLPlacemark *placemark;
}

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
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    if ([[[UIDevice currentDevice] systemVersion]floatValue]>= 8.0) {
        
        [locationManager requestWhenInUseAuthorization];
        //  [self.locationManager requestAlwaysAuthorization];
    }
    
    [locationManager startUpdatingLocation];
    geocoder = [[CLGeocoder alloc] init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*//*

- (IBAction)getMyLocation:(id)sender {
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([[[UIDevice currentDevice] systemVersion]floatValue]>= 8.0) {
        
        [locationManager requestWhenInUseAuthorization];
        //  [self.locationManager requestAlwaysAuthorization];
    }
    [locationManager startUpdatingLocation];
}*/

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"didFailWithError :%@" ,error);
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to get your location " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}
-(void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    NSLog(@"didUpdateToLocation %@", newLocation);
    CLLocation *currentLocation = newLocation;
    if(currentLocation != nil){
        _longitudeValue.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        _latitudeLabel.text =[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];

        
    }
}
   /* [locationManager stopUpdatingLocation];
    NSLog(@"Resolving the Address");
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            NSString *locatedAt =[[placemark.addressDictionary valueForKey:@"fdfddf"] componentsJoinedByString:@" , "];
            _addressLabel.text = locatedAt;
//         _addressLabel.text = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
//                                 placemark.subThoroughfare, placemark.thoroughfare,
//                                 placemark.postalCode, placemark.locality,
//                                 placemark.administrativeArea,
//                                 placemark.country];*/
    
 /*
    [geocoder reverseGeocodeLocation: currentLocation completionHandler:
    ^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        NSLog(@"placemark %@",placemark);
        //String to hold address
        NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
        NSLog(@"addressDictionary %@", placemark.addressDictionary);
        _addressLabel.text = [NSString stringWithFormat:@"%@ %@\n%@ %@\n",
                                                              placemark.region,
                                                              placemark.country,
                                                              placemark.locality,
                                                              placemark.administrativeArea
                             
                              ];
        NSLog(@"placemark %@",placemark.region);
        NSLog(@"placemark %@",placemark.country);  // Give Country Name
        NSLog(@"placemark %@",placemark.locality); // Extract the city name
        NSLog(@"location %@",placemark.name);
        NSLog(@"location %@",placemark.ocean);
        NSLog(@"location %@",placemark.postalCode);
        NSLog(@"location %@",placemark.subLocality);
        NSLog(@"location %@",placemark.subThoroughfare);

       // placemark.subThoroughfare
        NSLog(@"location %@",placemark.location);
        //Print the location to console
        NSLog(@"I am currently at %@",locatedAt);

    
    
    }
//     else
//    {
//            NSLog(@"%@", error.debugDescription);
//    
//    }
     ];


}*/
@end
