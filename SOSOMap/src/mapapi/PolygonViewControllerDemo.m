//
//  PolygonViewControllerDemo.m
//  SOSOMapAPIDemo
//
//  Created by wei lv on 12-7-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PolygonViewControllerDemo.h"

@interface PolygonViewControllerDemo ()

@end

@implementation PolygonViewControllerDemo
@synthesize mapView;

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
    mapView.delegate = self;
    //39.908716,116.397529
    CLLocationCoordinate2D polygonArray[] = 
    {   CLLocationCoordinate2DMake(40.008716,116.397529),
        CLLocationCoordinate2DMake(39.908716-0.1,116.397529+0.1),
        CLLocationCoordinate2DMake(39.908716 - 0.1,116.397529 -0.1),
    };
    QPolygon* polygon = [QPolygon polygonWithCoordinates:polygonArray count:sizeof(polygonArray)/sizeof(polygonArray[0])];
    
    [mapView addOverlay:polygon];
}

-(QOverlayView*)mapView:(QMapView *)mapView viewForOverlay:(id<QOverlay>)overlay
{
    if ([overlay isKindOfClass:[QPolygon class]]) {
        
        QPolygonView* polygonView= [[QPolygonView alloc] initWithPolygon:overlay];
        
        polygonView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:0.5];
		polygonView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
        
		polygonView.lineWidth = 5.0;
        return [polygonView autorelease];
    }
    
    return nil;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.mapView = nil;

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
