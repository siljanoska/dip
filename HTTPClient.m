//
//  HTTPClient.m
//  SidebarDemo
//
//  Created by Kireto on 10/3/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "HTTPClient.h"

@implementation HTTPClient
static NSString * const FoursquareOnlineApiKey =@"SCAUSJ20JI4KGYL5S5VMA3HZIQSDOABIERPA2DDGQNXJ5JEK";
static NSString * const FoursquareUrlString =@"http://api.foursquare.com/v2/venues/search?";

+(HTTPClient *)shareHttpClient{
    static HTTPClient *sharedHttpClient= nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedHttpClient=[[self alloc] initWithBaseURL:[NSURL URLWithString:FoursquareUrlString]];
    });
    return sharedHttpClient;
}

-(instancetype)initWithBaseURL:(NSURL *)url{
    self=[super initWithBaseURL:url];
    if(self){
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer =[AFJSONRequestSerializer serializer];
    }
    return self;
}



-(void)updateLocation:(CLLocation *)location {
    NSMutableDictionary *parametars =[NSMutableDictionary dictionary];
    parametars[@"client_id"]=@"SCAUSJ20JI4KGYL5S5VMA3HZIQSDOABIERPA2DDGQNXJ5JEK";
    parametars[@"client_secret"]=@"MZVY2IYB0GCDJMWXZTA3M52VG0NG5YJ54KTZDORRZKX0FU3P";
    parametars[@"v"]=@"20130815";
    parametars[@"ll"] =[NSString stringWithFormat:@"%f,%f", location.coordinate.latitude, location.coordinate.longitude];
  //  parametars[@"radius"] =@"10";
    NSLog(@"%f, %f" , location.coordinate.latitude, location.coordinate.longitude);
   
    //[self GET:@"https://api.foursquare.com/v2/venues/search?ll=40.7,-74&oauth_token=BIHVTUCXBZMMUWM2I23PZD5FJLNB132TOK5POLJE3UDZYT5Y&v=20141007" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject){
    [self GET:@"https://api.foursquare.com/v2/venues/search?" parameters:parametars success:^(NSURLSessionDataTask *task, id responseObject) {
        if([self.delegate respondsToSelector:@selector(LocationHttpClient:didUpdateLocaion:)]){
            [self.delegate LocationHttpClient:self didUpdateLocaion:responseObject];
        }
    }
      failure:^(NSURLSessionDataTask *task, NSError *error) {
          if([self.delegate respondsToSelector:@selector(LocationHttpClient:didFailWithError:)]){
              [self.delegate LocationHttpClient:self didFailWithError:error];
          }
      }];
}

@end