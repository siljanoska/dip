//
//  Globals.h
//  
//
//  Created by Kireto on 12/14/12.
//  Copyright (c) 2012 No Name. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Profil;

@interface Globals : NSObject
+ (float)osVersion;
+ (BOOL)isOSVerionGreaterThanOrEqualTo:(float)compareValue;
+ (BOOL)validateEmail:(NSString *)candidate;

+ (void)saveDate:(NSString*)value ;
+ (NSString*)loadSaveData;

+ (void)saveDateFrom:(NSString*)value ;
+ (NSString*)loadSaveDataFrom;

+ (void)saveDateTo:(NSString*)value ;
+ (NSString*)loadSaveDataTo;

+ (void)saveUserDefaultsBoolValue:(BOOL)value forKey:(NSString*)key;
+ (void)saveUserDefaultsStringValue:(NSString*)value forKey:(NSString*)key;
+ (BOOL)loadUserDefaultsBoolValueForKey:(NSString*)key;
+ (NSString*)loadUserDefaultsStringValueForKey:(NSString*)key;
+ (void)loadUserDefaults;
+ (void)saveRememberMeValue:(BOOL)value;
+ (void)saveLoginMailValue:(NSString*)value;
+ (void)saveLoginPassValue:(NSString*)value;
+ (BOOL)loadRemenmberMeValue;
+ (void)saveLoginName:(NSString*)value;

+ (NSString*)loadLoginNameValue;
+ (NSString*)loadLoginMailValue;
+ (NSString*)loadLoginPassValue;
+ (NSString*)encodeToPercentEscapeString:(NSString *)string;
+ (NSString*)decodeFromPercentEscapeString:(NSString *)string;

+ (void)customizeTabBarItem:(UITabBarItem*)tabBarItem forImage:(NSString*)imageName;
+ (void)customizeTitleForTabBarItem:(UITabBarItem*)tabBarItem;
+ (void)customizeSelctedImage:(NSString*)imageName forTabBarItem:(UITabBarItem*)tabBarItem;
+ (void)customizeTitleColor:(UIColor*)titleColor forTabBarItem:(UITabBarItem*)tabBarItem andState:(UIControlState)controlState;

+ (NSString*)checkSanityForURLstring:(NSString*)checkString;
+ (UIImage*)checkImage:(UIImage *)checkImage forRatio:(CGSize)ratioSize;
+ (UIImage*)checkImageRatio:(UIImage*)checkImage;

+ (UILabel*)labelWithFrame:(CGRect)labelFrame
                 labelFont:(UIFont*)labelFont
                labelColor:(UIColor*)labelColor
                 alignment:(NSTextAlignment)textAlignment
             andLabelTitle:(NSString*)labelTitle;

+ (UILabel*)labelWithFrame:(CGRect)labelFrame
             numberOfLines:(NSUInteger)numberOfLines
                 labelFont:(UIFont*)labelFont
                labelColor:(UIColor*)labelColor
                 alignment:(NSTextAlignment)textAlignment
             andLabelTitle:(NSString*)labelTitle;

+ (UILabel*)labelWithFrame:(CGRect)labelFrame
                 labelFont:(UIFont*)labelFont
                labelColor:(UIColor*)labelColor
                 alignment:(NSTextAlignment)textAlignment
                labelTitle:(NSString*)labelTitle
               shadowColor:(UIColor*)shadowColor
              shadowOffset:(CGSize)shadowOffset;

+ (void)saveUserProfilValue:(Profil*)value forKey:(NSString*)key;
+(void)saveCurrentProfil:(Profil*)profil;
+(Profil*)loadCurrentProfil;
//+(void)saveCurrentPressButton:(BOOL)value;
//+(BOOL)loadCurrentPressBtn;
@end
