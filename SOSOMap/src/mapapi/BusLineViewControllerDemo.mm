//
//  BusLineViewControllerDemo.m
//  SOSOMapAPIDemo
//
//  Created by wei lv on 12-8-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BusLineViewControllerDemo.h"

@interface BusLineViewControllerDemo ()

@end

@implementation BusLineViewControllerDemo
@synthesize mapView = _mapView;
@synthesize search = _search;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.mapView.delegate = self;
    
    QSearch* search = [[QSearch alloc] init];
    search.delegate = self;
    self.search = search;
    [search release];
    //UID 可以通过POI搜索获取到
    [_search busLineSearch:@"13134931090034453261"];//740
}

- (void)notifyBusLineSearchResult:(QBusLineSearchResult *)busLineSearchResult
{
    if (busLineSearchResult.errorCode == QBusLineSearchResultBusInfo) {
        
        QBusLineInfo* info = (QBusLineInfo*)[busLineSearchResult data];
        NSUInteger pointCount = info.busNodeCount;
        
        if (pointCount > 0) {
            QPolyline* pl = [QPolyline polylineWithCoordinates:info.busNodeList count:pointCount];
            
            [_mapView addOverlay:pl];
        }
    }
}

-(QOverlayView*)mapView:(QMapView *)mapView viewForOverlay:(id<QOverlay>)overlay
{
    if ([overlay isKindOfClass:[QPolyline class]]) {
        
        QPolylineView* polylineView = [[QPolylineView alloc] initWithPolyline:overlay];
        
        polylineView.lineWidth = 2.0;
		polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
        
        return [polylineView autorelease];
    }
    
    return nil;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [self.mapView release];
    self.mapView = nil;
    _search.delegate = nil;
    self.search = nil;
}

- (void)dealloc
{
    _mapView.delegate = nil;
    self.mapView = nil;
    _search.delegate = nil;
    self.search = nil;
    
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
