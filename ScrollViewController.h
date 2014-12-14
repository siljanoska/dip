//
//  ScrollViewController.h
//  SidebarDemo
//
//  Created by Kireto on 9/18/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)pageCgange:(id)sender;

@end
