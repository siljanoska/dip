//
//  Globals.m
//
//
//  Created by Kireto on 12/14/12.
//  Copyright (c) 2012 No Name. All rights reserved.
//

#import "Globals.h"
#import "Profil.h"
static BOOL rememberMe = NO;

static NSString *loginEmail = @"";
static NSString *loginPass = @"";
static NSString *dateFromPicker = @"";
static NSString *dateFromPickerFrom = @"";

static NSString *dateFromPickerTo = @"";

static NSString *loginName =@"";

static Profil *currentProfil;

NSString * const sUserDefaultsLoginName = @"UD::LoginName";
NSString * const sUserDefaultsRememberMe = @"UD::RememberMe";
NSString * const sUserDefaultsLoginMail = @"UD::LoginMail";
NSString * const sUserDefaultsLoginPass = @"UD::LoginPass";
NSString * const sUserDefaultsDate = @"UD::Date";
NSString * const sUserDefaultsDateFrom = @"UD::DateFrom";

NSString * const sUserDefaultsDateTo = @"UD::DateTo";

NSString * const sUserProfil =  @"UD::UserProfl";
NSString * const pressBtn =  @"UD::pressBtn";

@implementation Globals

+ (float)osVersion {
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+ (BOOL)isOSVerionGreaterThanOrEqualTo:(float)compareValue; {
    return ([Globals osVersion] >= compareValue);
}
//Validaton
+ (BOOL)validateEmail:(NSString *)candidate {
    NSString *emailRegEx =
    @"(?:[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-zA-Z0-9](?:[a-"
    @"z0-9-]*[a-zA-Z0-9])?\\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-zA-Z0-9-]*[a-zA-Z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [emailTest evaluateWithObject:candidate];
}

#pragma mark - 
#pragma mark - UserDefaults
+ (BOOL)loadUserDefaultsBoolValueForKey:(NSString*)key{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	BOOL retValue = NO;
	
	if (standardUserDefaults) {
		retValue = [standardUserDefaults boolForKey:key];
	}
	return retValue;
}

+ (NSString*)loadUserDefaultsStringValueForKey:(NSString*)key{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	NSString *retValue = @"";
	if (standardUserDefaults) {
		retValue = [standardUserDefaults stringForKey:key];
	}
    if (!retValue) {
        return @"";
    }
	return retValue;
}

+ (void)saveUserDefaultsBoolValue:(BOOL)value forKey:(NSString*)key{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	
	if (standardUserDefaults) {
		[standardUserDefaults setBool:value forKey:key];
		[standardUserDefaults synchronize];
    }
}

+ (void)saveUserDefaultsStringValue:(NSString*)value forKey:(NSString*)key{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	
	if (standardUserDefaults) {
		[standardUserDefaults setValue:value forKey:key];
		[standardUserDefaults synchronize];
    }
}
+ (void)saveUserProfilValue:(Profil*)value forKey:(NSString*)key{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setValue:value.nameP forKey:key];
        [standardUserDefaults synchronize];
        
    }
}

+ (void)loadUserDefaults {
    
    loginEmail = [Globals loadUserDefaultsStringValueForKey:sUserDefaultsLoginMail];
    loginPass = [Globals loadUserDefaultsStringValueForKey:sUserDefaultsLoginPass];
    rememberMe = [Globals loadUserDefaultsBoolValueForKey:sUserDefaultsRememberMe];
}
//+(void)saveCurrentPressButton:(BOOL)value{
//    currentPressBtn = &value;
//    [Globals saveUserDefaultsBoolValue:value forKey:pressBtn];
//}
//+(BOOL)loadCurrentPressBtn{
//    return *currentPressBtn;
//}
+(void)saveCurrentProfil:(Profil*)userProfil{
    currentProfil = userProfil;
    [Globals saveUserProfilValue:userProfil forKey:sUserProfil];
}
+(Profil*)loadCurrentProfil{
    return currentProfil;
}


+(void)saveLoginName:(NSString*)value {
    loginName = value;
    [Globals saveUserDefaultsStringValue:value forKey:sUserDefaultsLoginName];
    
}
+ (void)saveRememberMeValue:(BOOL)value {
    rememberMe = value;
    [Globals saveUserDefaultsBoolValue:value forKey:sUserDefaultsRememberMe];
}

+ (void)saveLoginMailValue:(NSString*)value {
    loginEmail = value;
    [Globals saveUserDefaultsStringValue:value forKey:sUserDefaultsLoginMail];
}

+ (void)saveLoginPassValue:(NSString*)value {
    loginPass = value;
    [Globals saveUserDefaultsStringValue:value forKey:sUserDefaultsLoginPass];
}

+ (void)saveDate:(NSString*)value {
    dateFromPicker = value;
    [Globals saveUserDefaultsStringValue:value forKey:sUserDefaultsDate];
}

+ (void)saveDateFrom:(NSString*)value {
    dateFromPickerFrom = value;
    [Globals saveUserDefaultsStringValue:value forKey:sUserDefaultsDateFrom];
}
+ (void)saveDateTo:(NSString*)value {
    dateFromPickerTo = value;
    [Globals saveUserDefaultsStringValue:value forKey:sUserDefaultsDateTo];
}


+(NSString*)loadLoginNameValue{
    return loginName;
}
+ (NSString*)loadSaveData {
    return dateFromPicker;
}
+ (NSString*)loadSaveDataFrom {
    return dateFromPickerFrom;
}
+ (NSString*)loadSaveDataTo {
    return dateFromPickerTo;
}
+ (BOOL)loadRemenmberMeValue {
    return rememberMe;
}

+ (NSString*)loadLoginMailValue {
    return loginEmail;
}

+ (NSString*)loadLoginPassValue {
    return loginPass;
}

+ (NSString*)encodeToPercentEscapeString:(NSString *)string {
    return (__bridge_transfer NSString *)
    CFURLCreateStringByAddingPercentEscapes(NULL,
                                            (__bridge CFStringRef) string,
                                            NULL,
                                            (CFStringRef) @"!*'\"();:@&=+$,/?%#[]% ",
                                            kCFStringEncodingUTF8);
}

+ (NSString*)decodeFromPercentEscapeString:(NSString *)string {
    return (__bridge_transfer NSString *)
    CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                            (__bridge CFStringRef) string,
                                                            (CFStringRef) @"!*'\"();:@&=+$,/?%#[]% ",
                                                            kCFStringEncodingUTF8);
}

+ (void)customizeTabBarItem:(UITabBarItem*)tabBarItem forImage:(NSString*)imageName {
    
    [tabBarItem setFinishedSelectedImage:[UIImage imageNamed:imageName]
             withFinishedUnselectedImage:[UIImage imageNamed:imageName]];
}

+ (void)customizeTitleForTabBarItem:(UITabBarItem*)tabBarItem {
    
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIColor whiteColor], UITextAttributeTextColor,
                                        [UIFont fontWithName:@"Avenir-Light" size:12.0], UITextAttributeFont, nil]
                              forState:UIControlStateSelected];
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIColor whiteColor], UITextAttributeTextColor,
                                        [UIFont fontWithName:@"Avenir-Light" size:12.0], UITextAttributeFont, nil]
                              forState:UIControlStateNormal];
}

+ (void)customizeSelctedImage:(NSString*)imageName forTabBarItem:(UITabBarItem*)tabBarItem {
    [tabBarItem setSelectedImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}

+ (void)customizeTitleColor:(UIColor*)titleColor forTabBarItem:(UITabBarItem*)tabBarItem andState:(UIControlState)controlState {
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        titleColor, UITextAttributeTextColor, nil]
                              forState:controlState];
}

+ (NSString*)checkSanityForURLstring:(NSString*)checkString {
    
    NSString *retString = @"";
    if ([checkString length]>4 && [[checkString substringToIndex:4] isEqualToString:@"http"]) {
        retString = checkString;
    }
    else {
//        retString = [NSString stringWithFormat:@"%@%@", RESOURCES_BASE_URL, checkString];
    }
    return retString;
}

+ (UIImage*)checkImage:(UIImage *)checkImage forRatio:(CGSize)ratioSize {
    
    UIImage *retImage = checkImage;
    CGSize imageSize = checkImage.size;
    if (imageSize.height*ratioSize.width > imageSize.width*ratioSize.height) {
        imageSize.height = (imageSize.width * ratioSize.height)/ratioSize.width;
        
        CGRect cropRect = CGRectMake(0.0, 0.0, imageSize.width*checkImage.scale, imageSize.height*checkImage.scale);
        CGImageRef croppedImage = CGImageCreateWithImageInRect([checkImage CGImage], cropRect);
        retImage = [UIImage imageWithCGImage:croppedImage];
    }
    else {
        imageSize.width = (imageSize.height * ratioSize.width)/ratioSize.height;
        
        CGRect cropRect = CGRectMake(((checkImage.size.width - imageSize.width)/2)*checkImage.scale, 0.0, imageSize.width*checkImage.scale, imageSize.height*checkImage.scale);
        CGImageRef croppedImage = CGImageCreateWithImageInRect([checkImage CGImage], cropRect);
        retImage = [UIImage imageWithCGImage:croppedImage];
    }
    return retImage;
}

+ (UIImage*)checkImageRatio:(UIImage *)checkImage {
    
    UIImage *retImage = checkImage;
    CGSize imageSize = checkImage.size;
    if (imageSize.height*16 > imageSize.width*10) {
        imageSize.height = (imageSize.width * 10)/16.0;
        
        CGRect cropRect = CGRectMake(0.0, 0.0, imageSize.width*checkImage.scale, imageSize.height*checkImage.scale);
        CGImageRef croppedImage = CGImageCreateWithImageInRect([checkImage CGImage], cropRect);
        retImage = [UIImage imageWithCGImage:croppedImage];
    }
    else {
        imageSize.width = (imageSize.height * 16)/10.0;
        
        CGRect cropRect = CGRectMake(((checkImage.size.width - imageSize.width)/2)*checkImage.scale, 0.0, imageSize.width*checkImage.scale, imageSize.height*checkImage.scale);
        CGImageRef croppedImage = CGImageCreateWithImageInRect([checkImage CGImage], cropRect);
        retImage = [UIImage imageWithCGImage:croppedImage];
    }
    return retImage;
}

+ (UILabel*)labelWithFrame:(CGRect)labelFrame
                 labelFont:(UIFont*)labelFont
                labelColor:(UIColor*)labelColor
                 alignment:(NSTextAlignment)textAlignment
             andLabelTitle:(NSString*)labelTitle {
    
    UILabel *returnLabel = [[UILabel alloc] initWithFrame:labelFrame];
    returnLabel.backgroundColor = [UIColor clearColor];
    returnLabel.font = labelFont;
    returnLabel.textColor = labelColor;
    returnLabel.textAlignment = textAlignment;
    returnLabel.text = labelTitle;
    return returnLabel;
}

+ (UILabel*)labelWithFrame:(CGRect)labelFrame
             numberOfLines:(NSUInteger)numberOfLines
                 labelFont:(UIFont*)labelFont
                labelColor:(UIColor*)labelColor
                 alignment:(NSTextAlignment)textAlignment
             andLabelTitle:(NSString*)labelTitle {
    
    UILabel *returnLabel = [[UILabel alloc] initWithFrame:labelFrame];
    returnLabel.backgroundColor = [UIColor clearColor];
    returnLabel.font = labelFont;
    returnLabel.textColor = labelColor;
    returnLabel.textAlignment = textAlignment;
    returnLabel.numberOfLines = numberOfLines;
    returnLabel.text = labelTitle;
    return returnLabel;
}

+ (UILabel*)labelWithFrame:(CGRect)labelFrame
                 labelFont:(UIFont*)labelFont
                labelColor:(UIColor*)labelColor
                 alignment:(NSTextAlignment)textAlignment
                labelTitle:(NSString*)labelTitle
               shadowColor:(UIColor*)shadowColor
              shadowOffset:(CGSize)shadowOffset {
    
    UILabel *returnLabel = [Globals labelWithFrame:labelFrame
                                         labelFont:labelFont
                                        labelColor:labelColor
                                         alignment:textAlignment
                                     andLabelTitle:labelTitle];
    returnLabel.shadowColor = shadowColor;
    returnLabel.shadowOffset = shadowOffset;
    return returnLabel;
}

@end
