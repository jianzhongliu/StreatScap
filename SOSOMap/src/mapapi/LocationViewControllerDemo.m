//
//  LocationViewControllerDemo.m
//  SOSOMapAPIDemo
//
//  Created by wei lv on 12-7-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LocationViewControllerDemo.h"

@interface LocationViewControllerDemo ()

@end

@implementation LocationViewControllerDemo
@synthesize mapView = _mapView;

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
    _mapView.delegate = self;
    [_mapView setShowsUserLocation:YES];
}

- (void)mapViewWillStartLocatingUser:(QMapView *)mapView 
{
    
}
- (void)mapViewDidStopLocatingUser:(QMapView *)mapView
{
    
}


- (void)mapView:(QMapView *)mapView didUpdateUserLocation:(QUserLocation *)userLocation 
{
//    NSLog(@"userlocation chanage lo=%f,lat= %f",
//          [userLocation location].coordinate.longitude,
//          [userLocation location].coordinate.latitude);
}


- (void)mapView:(QMapView *)mapView didFailToLocateUserWithError:(NSError *)error 
{
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [_mapView setShowsUserLocation:NO];
    _mapView.delegate = nil;
    self.mapView = nil;
}

- (void)dealloc
{
    [_mapView setShowsUserLocation:NO];
    _mapView.delegate = nil;
    self.mapView = nil;
    
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
