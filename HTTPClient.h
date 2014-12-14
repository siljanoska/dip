//
//  HTTPClient.h
//  SidebarDemo
//
//  Created by Kireto on 10/3/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import <CoreLocation/CoreLocation.h>

@ protocol HTTPClientDelegate;


@interface HTTPClient : AFHTTPSessionManager
@property(nonatomic , weak) id<HTTPClientDelegate>delegate;

+(HTTPClient *)shareHttpClient;
-(instancetype)initWithBaseURL:(NSURL *)url;
-(void)updateLocation:(CLLocation *)location;
@end

@protocol HTTPClientDelegate <NSObject>
-(void)LocationHttpClient:(HTTPClient *)client didUpdateLocaion:(id)location;
-(void)LocationHttpClient:(HTTPClient *)client didFailWithError:(NSError *)error;
@end