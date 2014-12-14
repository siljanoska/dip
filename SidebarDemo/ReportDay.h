//
//  ReportDay.h
//  SidebarDemo
//
//  Created by Kireto on 9/19/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportDay : UIView
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic ) IBOutlet NSMutableArray *listaKategorii;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign) int amountAggregate;
@property (nonatomic,assign) int amountPom;
@property (strong) NSMutableArray *objectCat;
@property (strong) NSMutableArray *objectList;
@property (nonatomic,assign) int vkupno;
@end
