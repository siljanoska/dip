#import "APYahooDataPuller.h"
#import "CorePlot-CocoaTouch.h"
#import <UIKit/UIKit.h>

@class CPTGraphHostingView;
@class APYahooDataPuller;
@class CPTXYGraph;

@interface MainViewController : UIViewController<APYahooDataPullerDelegate, CPTPlotDataSource> {
	CPTGraphHostingView *graphHost;

	@private
	APYahooDataPuller *datapuller;
	CPTXYGraph *graph;
}
- (IBAction)PressExpresseButton:(id)sender;

@property (nonatomic, retain) IBOutlet CPTGraphHostingView *graphHost;

@end
