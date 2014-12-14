//
//  DebtsView.m
//  SidebarDemo
//
//  Created by TheMac on 11/19/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "DebtsView.h"

@implementation DebtsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [[NSBundle mainBundle ] loadNibNamed:@"DebtsView" owner:self options:nil];
        [self
         addSubview:self.view];
    }
    return self;
}

@end
