//
//  CircleViewControllerDemo.m
//  SOSOMapAPIDemo
//
//  Created by wei lv on 12-7-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CircleViewControllerDemo.h"

@interface CircleViewControllerDemo()

@end

@implementation CircleViewControllerDemo
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
    //circle
    CLLocationCoordinate2D coor;
    coor.longitude = 116.397529;
    coor.latitude = 39.908716;
    
    QCircle* circle = [QCircle circleWithCenterCoordinate:coor 
                                                   radius:15000];
    [mapView addOverlay:circle];
}

- (QOverlayView *)mapView:(QMapView *)mapView viewForOverlay:(id <QOverlay>)overlay 
{
    if ([overlay isKindOfClass:[QCircle class]]) {
        
        QCircleView* circleView = [[QCircleView alloc] initWithCircle:overlay];
        circleView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:0.5];
		circleView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
		circleView.lineWidth = 5.0;
        
        return [circleView autorelease];
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
