//
//  SmartTripsViewController.m
//  SOSOMapAPIDemo
//
//  Created by lv wei on 12-12-21.
//
//

#import "SmartTripsViewControllerDemo.h"

@interface SmartTripsViewControllerDemo ()
- (void)showAlertView:(NSString*)title widthMessage:(NSString*)message;
@end

@implementation SmartTripsViewControllerDemo
@synthesize mapView = _mapView;
@synthesize search = _search;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    // Do any additional setup after loading the view from its nib.
    
    // Do any additional setup after loading the view from its nib.
    _mapView.delegate = self;
    
    QSearch* search = [[QSearch alloc] init];
    search.delegate = self;
    self.search = search;
    [search release];
    [_search smartTripSearch:@"北京" widthKeyWord:@"as"];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.search = nil;
    self.mapView = nil;
}

- (void)dealloc
{
    _search.delegate = nil;
    [_search release];
    _search = nil;
    
    _mapView.delegate = nil;
    [_mapView release];
    _mapView = nil;
    
    [super dealloc];
}

- (void)notifySmartTripsResult:(QSmartTripsResult *)smartTripsResult
{
    if (smartTripsResult.errorCode == QSmartTripsList) {
        
        NSArray* tripList = [smartTripsResult data];
        
        NSMutableString* msg = [[NSMutableString alloc] init];
        
        for (NSString* str in tripList) {
            [msg appendFormat:@"%@\n",str];
        }
        
        [self showAlertView:@"智能提示，搜索建议" widthMessage:msg];
        [msg release];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)showAlertView:(NSString*)title widthMessage:(NSString*)message
{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView sizeToFit];
	[alertView show];
	[alertView release];
}

@end
