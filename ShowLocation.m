//
//  ShowLocation.m
//  SidebarDemo
//
//  Created by Kireto on 10/2/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "ShowLocation.h"
#import "HTTPClient.h"
#import "NSDictionary+venue.h"
#import "NSDictionary+VenueD.h"
@implementation ShowLocation


-(void)viewDidLoad{
    [super viewDidLoad];

    self.locationManager =[[CLLocationManager alloc] init];
    self.locationManager.delegate =self;
    if ([[[UIDevice currentDevice] systemVersion]floatValue]>= 8.0) {
        
        [_locationManager requestWhenInUseAuthorization];
    }

    [self.locationManager startUpdatingLocation];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    _venue = [self.venues venuess];
     NSLog(@"%lu" , (unsigned long)[_venue count]);
    return [_venue count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellId = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    //NSDictionary *meta= [_venues meta];
  
    // NSInteger code= [meta metacode];
    _venue = [self.venues venuess];
   // _numberOfVenues = [_venue count];
   // NSLog(@"%@",_numberOfVenues);
  //  NSLog(@"%lu", (unsigned long)[_venue count]);
    
    /*  for(int i=0 ; i< [venue count] ;i++){
        NSDictionary *dic = venue[i];
        NSString * name = [dic nameVenues];
        NSLog(@"ima : %@" , name);
        cell.textLabel.text = name;

    }*/
    NSDictionary *dic =[_venue objectAtIndex:indexPath.row];
    NSString * name = [dic nameVenues];
    cell.textLabel.text = name;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    _locationName = cell.textLabel.text;
    NSLog(@"NAME LOCATION : %@" , _locationName);
    [self.delegateLocationName locationName:_locationName];
    [self.navigationController popViewControllerAnimated:YES];

    
    
}

-(void)LocationHttpClient:(HTTPClient *)client didFailWithError:(NSError *)error{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                        message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
}
-(void)LocationHttpClient:(HTTPClient *)client didUpdateLocaion:(id)location{
    _venues= location;
  // NSDictionary *meta= [_venues meta];
  // NSInteger code= [meta metacode];
    self.title =@"Location";
    [self.tableView reloadData];
    
}


- (IBAction)jsonTapp:(id)sender {

   [self.locationManager startUpdatingLocation];

}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    CLLocation *newlocation = [locations lastObject];
    NSLog(@"drfdfdfddfdf %f... %f", newlocation.coordinate.latitude , newlocation.coordinate.longitude);
   // if([newlocation.timestamp timeIntervalSinceNow ] >1000)
    //    return;
    [self.locationManager stopUpdatingLocation];
    HTTPClient *client =[HTTPClient shareHttpClient];
    client.delegate =self;
    [client updateLocation:newlocation ];
    
}


@end
