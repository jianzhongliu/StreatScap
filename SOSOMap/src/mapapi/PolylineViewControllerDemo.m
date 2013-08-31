//
//  PolylineViewControllerDemo.m
//  SOSOMapAPIDemo
//
//  Created by wei lv on 12-7-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PolylineViewControllerDemo.h"

@interface PolylineViewControllerDemo ()

@end

@implementation PolylineViewControllerDemo
@synthesize mapView;

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
    mapView.delegate = self;
    CLLocationCoordinate2D polylineArray[] = 
    {   CLLocationCoordinate2DMake(40.008716,116.397529),
        CLLocationCoordinate2DMake(39.908716-0.1,116.397529+0.1),
        CLLocationCoordinate2DMake(39.908716 - 0.1,116.397529 -0.1),
        CLLocationCoordinate2DMake(39.908716 - 0.2,116.397529 -0.1),
    };
    
    QPolyline* polyline = [QPolyline polylineWithCoordinates:polylineArray count:sizeof(polylineArray)/sizeof(polylineArray[0])];
    
    [mapView addOverlay:polyline];
}

-(QOverlayView*)mapView:(QMapView *)mapView viewForOverlay:(id<QOverlay>)overlay
{
    if ([overlay isKindOfClass:[QPolyline class]]) {
        
        QPolylineView* polylineView = [[QPolylineView alloc] initWithPolyline:overlay];
        
        polylineView.lineWidth = 5.0;
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
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
