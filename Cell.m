//
//  Cell.m
//  SidebarDemo
//
//  Created by Kireto on 8/21/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "Cell.h"

@implementation Cell

- (instancetype)initWithFrame:(CGRect)frameRect
{
    self = [super initWithFrame:frameRect];
    if (self) {
        // Initialization code
    
        self.imageCell = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:self.imageCell];
        
        
    }
    
    
    
    return self;
}

@end
