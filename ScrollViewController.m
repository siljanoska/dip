//
//  ScrollViewController.m
//  SidebarDemo
//
//  Created by Kireto on 9/18/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "ScrollViewController.h"
#import "ReportDayViewController.h"
#import "ReportMonthViewController.h"
#import "ReportYearViewController.h"
#import "ReportCustomViewController.h"
@interface ScrollViewController ()

@end

@implementation ScrollViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width*4,1)]; // so ova mu pravam goleminata na scrollView to da e tri pati po goleminata na edno view

    
    self.scrollView.delegate =self;
   /* UIStoryboard * storyB = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    ReportDayViewController *reportDay = [storyB instantiateViewControllerWithIdentifier:@"dayID"]  ;
   
    [reportDay.view setFrame:CGRectMake(0,0,self.scrollView.frame.size.width, self.scrollView.frame.size.width)];
    [self.scrollView addSubview:reportDay.view];
    ReportMonthViewController *reportMonth = [storyB instantiateViewControllerWithIdentifier:@"MonthID"]  ;
   // ReportMonthViewController *reportMonth = [[ReportMonthViewController alloc] init];
    [reportMonth.view setFrame:CGRectMake(self.scrollView.frame.size.width, 0 ,self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    [self.scrollView addSubview:reportMonth.view];
    ReportYearViewController *reportYear = [storyB instantiateViewControllerWithIdentifier:@"YearID"]  ;

    //ReportYearViewController *reportYear = [[ReportYearViewController alloc] init];
    [reportYear.view setFrame:CGRectMake(2*self.scrollView.frame.size.width, 0 ,self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
   [self.scrollView addSubview:reportYear.view];
    ReportCustomViewController *reportCustom = [storyB instantiateViewControllerWithIdentifier:@"CustomID"]  ;

   // ReportCustomViewController *reportCustom = [[ReportCustomViewController alloc] init];
    [reportCustom.view setFrame:CGRectMake(3*self.scrollView.frame.size.width, 0 ,self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    [self.scrollView addSubview:reportCustom.view];
    self.pageControl.numberOfPages=4;
    [self.view addSubview: self.scrollView];
    [self.view addSubview: self.pageControl];*/
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat viewWidth = scrollView.frame.size.width;
    int pagaNumber= floor ((scrollView.contentOffset.x - viewWidth/50)/viewWidth)+1;
    self.pageControl.currentPage =pagaNumber;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)pageCgange:(id)sender {
    
    int pageNumber = (int)self.pageControl.currentPage;
    CGRect frame = self.scrollView.frame;
    frame.origin.x =frame.size.width*pageNumber;
    frame.origin.y= 0;
    [self.scrollView scrollRectToVisible:frame animated:YES];
}/*
-(void)viewDidUnload{
    [self setPageControl:nil];
    [super viewDidUnload];
}*/
@end
