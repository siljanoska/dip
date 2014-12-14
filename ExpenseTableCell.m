//
//  ExpenseTableCell.m
//  SidebarDemo
//
//  Created by TheMac on 12/4/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "ExpenseTableCell.h"

@implementation ExpenseTableCell

- (void)awakeFromNib {
    [_whoPaidLabel sizeToFit];
    [_amountLabel sizeToFit];
//       NSString *text1 = [NSString stringWithFormat:@"%@",_whoPaidLabel];
//       CGSize constraint1 = CGSizeMake(280, 2000);
//
//    CGSize size1 = [text1 sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:constraint1 ];
//    _whoPaidLabel = [[UILabel alloc] initWithFrame:CGRectMake(240  , 22,size1.width,size1.height)] ;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
