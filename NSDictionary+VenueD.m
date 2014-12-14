//
//  NSDictionary+VenueD.m
//  SidebarDemo
//
//  Created by Kireto on 10/2/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "NSDictionary+VenueD.h"

@implementation NSDictionary (VenueD)

-(NSArray *)venuess
{
    NSDictionary *dic=self[@"response"];
    NSArray *ar=dic[@"venues"];
    return ar;
}/*
-(NSString *)meta{
    NSDictionary *dic=self[@"meta"];
    NSString *code = dic[@"code"];
    return code;
}*/
-(NSDictionary *)meta{
    NSDictionary *dic=self[@"meta"];
    return dic;
}


@end
