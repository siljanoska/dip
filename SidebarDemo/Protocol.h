//
//  Protocol.h
//  SidebarDemo
//
//  Created by Kireto on 8/19/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class  AddCategory;
@class  DateViewController;
@class FacebookLoginViewController;
@class AppViewController;
@class ShowLocation;
@class MembersViewController;
@protocol AddNewCategoryProtocol <NSObject>

@end

@protocol DateProtocol <NSObject>
-(void) dateString: (NSString *)date;
-(void) dateDate : (NSDate *)date;
@end

@protocol NameProtocol <NSObject>
-(void) nameProfil:(NSString *)name;
@end

@protocol PhotoFromCameraProtocol <NSObject>
-(void) photoFromCamera:(UIImage *)image;
@end
@protocol PhotoFromCameraPathProtocol <NSObject>
-(void) photoFromCameraPath:(NSString *)path;
@end

@protocol LocationNameProtocol <NSObject>

-(void)locationName:(NSString *)name;

@end
@protocol ArrayOfMembersInGroupeProtocol <NSObject>
-(void)arrayOfMembersInGroupe:(NSArray *)array;


@end