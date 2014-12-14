//
//  RecentEntityCell.m
//  SidebarDemo
//
//  Created by Kireto on 9/5/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "RecentEntityCell.h"

@implementation RecentEntityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
       /*
        [self.contentView addSubview:_CategoryLabel];
        [self.contentView addSubview:_TimeLabel];
        [self.contentView addSubview:_DateLabel];
        [self.contentView addSubview:_DescriptLabel];
*/
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
