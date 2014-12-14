//
//  AddItemViewController.h
//  SidebarDemo
//
//  Created by Kireto on 8/19/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Category.h"
#import "Protocol.h"
@class Profil;
@class CategoryPom;
@interface AddItemViewController : UIViewController <UICollectionViewDataSource ,UICollectionViewDelegate>


//@property (nonatomic , weak) id<AddNewCategoryProtocol>delegate;
@property (assign, nonatomic)  int flag;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak , nonatomic) IBOutlet NSString *categoryname;
@property (strong , nonatomic) CategoryPom *categoryPom;
@property (strong, nonatomic)   Profil *profilC;
@property (strong , nonatomic) IBOutlet NSArray *imageCategory;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
- (IBAction)pressSaveItemBtn:(id)sender;


@end
