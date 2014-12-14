//
//  RecentEntityCell.h
//  SidebarDemo
//
//  Created by Kireto on 9/5/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecentEntityCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *AmountLabel;
//@property (weak, nonatomic) IBOutlet UILabel *AmountLabel;
@property (weak, nonatomic) IBOutlet  UIImageView *image;
@property (weak , nonatomic) IBOutlet UILabel *CategoryLabel;
@property (weak , nonatomic) IBOutlet UILabel *DateLabel;
@property (weak , nonatomic) IBOutlet UILabel *TimeLabel;
@property (weak , nonatomic) IBOutlet UILabel *DescriptLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationNameLabel;

@end

