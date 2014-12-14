//
//  Profil.h
//  SidebarDemo
//
//  Created by TheMac on 12/11/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CategoryPom, Groupe, Member;

@interface Profil : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * nameP;
@property (nonatomic, retain) CategoryPom *categoryProfil;
@property (nonatomic, retain) NSSet *profillGroups;
@property (nonatomic, retain) NSSet *profilMember;
@end

@interface Profil (CoreDataGeneratedAccessors)

- (void)addProfillGroupsObject:(Groupe *)value;
- (void)removeProfillGroupsObject:(Groupe *)value;
- (void)addProfillGroups:(NSSet *)values;
- (void)removeProfillGroups:(NSSet *)values;

- (void)addProfilMemberObject:(Member *)value;
- (void)removeProfilMemberObject:(Member *)value;
- (void)addProfilMember:(NSSet *)values;
- (void)removeProfilMember:(NSSet *)values;

@end
