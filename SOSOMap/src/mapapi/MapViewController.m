//
//  ViewController.m
//  SOSOMapAPIDemo
//
//  Created by wei lv on 12-7-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "MapViewViewControllerDemo.h"
#import "AnnotationViewControllerDemo.h"
#import "PolylineViewControllerDemo.h"
#import "PolygonViewControllerDemo.h"
#import "CircleViewControllerDemo.h"
#import "LocationViewControllerDemo.h"
#import "TrafficViewControllerDemo.h"
#import "GeocodeViewControllerDemo.h"
#import "CircleViewControllerDemo.h"
#import "AnnotationViewControllerDemo.h"
#include "PoiSearchViewControllerDemo.h"
#import "RoundSearchViewControllerDemo.h"
#import "BusRouteSearchViewControllerDemo.h"
#import "DriveRouteSearchViewControllerDemo.h"
#import "BusLineViewControllerDemo.h"
#import "ReverseGeocoderViewControllerDemo.h"
#import "SmartTripsViewControllerDemo.h"
#import "QAppKeyCheck.h"

@interface MapViewController ()
{
    NSMutableDictionary* _viewControllerList;
    UIViewController * curController;
}

@property(nonatomic,retain) NSDictionary* viewControllerList;

@end

@implementation MapViewController
@synthesize mapBtn;
@synthesize locationBtn;
@synthesize trafficBtn;
@synthesize annotationBtn;
@synthesize polylineBtn;
@synthesize polygonBtn;
@synthesize circleBtn;

@synthesize poiSearchBtn;
@synthesize roundSearchBtn;
@synthesize busRouteSearchBtn;
@synthesize driveRouteSearchBtn;
@synthesize buslineSearchBtn;
@synthesize geocoderBtn;
@synthesize reverseGeocoderBtn;
@synthesize viewControllerList = _viewControllerList;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"地图测试DEMO";
    
    
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] initWithCapacity:14];
    
    MapViewViewControllerDemo* mapViewViewControllerDemo = [[MapViewViewControllerDemo alloc] initWithNibName:@"MapViewViewControllerDemo" bundle:nil] ;
    [dic setObject:mapViewViewControllerDemo forKey:@"MapViewControllerDemo"];
    [mapViewViewControllerDemo release];
    
    LocationViewControllerDemo* locationViewControllerDemo = [[LocationViewControllerDemo alloc] initWithNibName:@"LocationViewControllerDemo" bundle:nil];
    [dic setObject:locationViewControllerDemo forKey:@"LocationViewControllerDemo"];
    [locationViewControllerDemo release];
    
    TrafficViewControllerDemo* trafficViewControllerDemo = [[TrafficViewControllerDemo alloc] initWithNibName:@"TrafficViewControllerDemo" bundle:nil];
    [dic setObject:trafficViewControllerDemo forKey:@"TrafficViewControllerDemo"];
    [trafficViewControllerDemo release];
    
     AnnotationViewControllerDemo* annotationViewControllerDemo = [[AnnotationViewControllerDemo alloc] initWithNibName:@"AnnotationViewControllerDemo" bundle:nil];
    [dic setObject:annotationViewControllerDemo forKey:@"AnnotationViewControllerDemo"];
    [annotationViewControllerDemo release];
    
    
    PolylineViewControllerDemo* polylineViewControllerDemo = [[PolylineViewControllerDemo alloc] initWithNibName:@"PolylineViewControllerDemo" bundle:nil];
    [dic setObject:polylineViewControllerDemo forKey:@"PolylineViewControllerDemo"];
    [polylineViewControllerDemo release];
    
    PolygonViewControllerDemo* polygonViewControllerDemo = [[PolygonViewControllerDemo alloc] initWithNibName:@"PolygonViewControllerDemo" bundle:nil];
    [dic setObject:polygonViewControllerDemo forKey:@"PolygonViewControllerDemo"];
    [polygonViewControllerDemo release];
    
    CircleViewControllerDemo* circleViewControllerDemo = [[CircleViewControllerDemo alloc] initWithNibName:@"CircleViewControllerDemo" bundle:nil];
    [dic setObject:circleViewControllerDemo forKey:@"CircleViewControllerDemo"];
    [circleViewControllerDemo release];
    
    PoiSearchViewControllerDemo* poiSearchViewControllerDemo = [[PoiSearchViewControllerDemo alloc] initWithNibName:@"PoiSearchViewControllerDemo" bundle:nil];
    [dic setObject:poiSearchViewControllerDemo forKey:@"PoiSearchViewControllerDemo"];
    [poiSearchViewControllerDemo release];
    
    RoundSearchViewControllerDemo* roundSearchViewControllerDemo = [[RoundSearchViewControllerDemo alloc] initWithNibName:@"RoundSearchViewControllerDemo" bundle:nil];
    [dic setObject:roundSearchViewControllerDemo forKey:@"RoundSearchViewControllerDemo"];
    [roundSearchViewControllerDemo release];
    
    BusRouteSearchViewControllerDemo* busRouteSearchViewControllerDemo = [[BusRouteSearchViewControllerDemo alloc] initWithNibName:@"BusRouteSearchViewControllerDemo" bundle:nil];
    [dic setObject:busRouteSearchViewControllerDemo forKey:@"BusRouteSearchViewControllerDemo"];
    [busRouteSearchViewControllerDemo release];
    
    DriveRouteSearchViewControllerDemo* driveRouteSearchViewControllerDemo = [[DriveRouteSearchViewControllerDemo alloc] initWithNibName:@"DriveRouteSearchViewControllerDemo" bundle:nil];
    [dic setObject:driveRouteSearchViewControllerDemo forKey:@"DriveRouteSearchViewControllerDemo"];
    [driveRouteSearchViewControllerDemo release];
    
    BusLineViewControllerDemo* busLineViewControllerDemo = [[BusLineViewControllerDemo alloc] initWithNibName:@"BusLineViewControllerDemo" bundle:nil];
    [dic setObject:busLineViewControllerDemo forKey:@"BusLineViewControllerDemo"];
    [busLineViewControllerDemo release];
    
    GeocodeViewControllerDemo* geocodeViewControllerDemo = [[GeocodeViewControllerDemo alloc] initWithNibName:@"GeocodeViewControllerDemo" bundle:nil];
    [dic setObject:geocodeViewControllerDemo forKey:@"GeocodeViewControllerDemo"];
    [geocodeViewControllerDemo release];
    
    ReverseGeocoderViewControllerDemo* reverseGeocoderViewControllerDemo = [[ReverseGeocoderViewControllerDemo alloc] initWithNibName:@"ReverseGeocoderViewControllerDemo" bundle:nil];
    [dic setObject:reverseGeocoderViewControllerDemo forKey:@"ReverseGeocoderViewControllerDemo"];
    [reverseGeocoderViewControllerDemo release];
    
    SmartTripsViewControllerDemo* smartTripsControllerDemo = [[SmartTripsViewControllerDemo alloc] initWithNibName:@"SmartTripsViewControllerDemo" bundle:nil];
    [dic setObject:smartTripsControllerDemo forKey:@"SmartTripsViewControllerDemo"];
    [smartTripsControllerDemo release];
    
    [self.navigationController setModalInPopover:NO];
    self.viewControllerList = dic;
    [dic release];
}

- (void)viewDidUnload
{
    self.mapBtn = nil;
    self.locationBtn = nil;
    self.trafficBtn = nil;
    self.annotationBtn = nil;
    self.polygonBtn = nil;
    self.polylineBtn = nil;
    self.circleBtn = nil;
    self.poiSearchBtn = nil;
    self.roundSearchBtn = nil;
    self.busRouteSearchBtn = nil;
    self.driveRouteSearchBtn = nil;
    self.buslineSearchBtn = nil;
    self.geocoderBtn = nil;
    self.reverseGeocoderBtn = nil;
    
    self.viewControllerList = nil;
    [super viewDidUnload];
}

- (void)dealloc
{
    [mapBtn release];
    [locationBtn release];
    [trafficBtn release];
    [annotationBtn release];
    [polylineBtn release];
    [polygonBtn release];
    [circleBtn release];
    [poiSearchBtn release];
    [roundSearchBtn release];
    [busRouteSearchBtn release];
    [driveRouteSearchBtn release];
    [buslineSearchBtn release];
    [geocoderBtn release];
    [reverseGeocoderBtn release];
    
    [_viewControllerList release];
    [_appKeyCheck release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}


-(IBAction)mapButtonEvent:(id)sender
{

    MapViewViewControllerDemo * demo = [_viewControllerList objectForKey:@"MapViewControllerDemo"];

    [self.navigationController pushViewController:demo animated:YES];
}

-(IBAction)locationButtonEvent:(id)sender
{

    LocationViewControllerDemo* demo = [_viewControllerList objectForKey:@"LocationViewControllerDemo"];
    [self.navigationController pushViewController:demo animated:YES];
    
}

-(IBAction)trafficButtonEvent:(id)sender
{
    TrafficViewControllerDemo* demo = [_viewControllerList objectForKey:@"TrafficViewControllerDemo"];
    [self.navigationController pushViewController:demo animated:YES];
}

-(IBAction)annotationButtonEvent:(id)sender
{
    AnnotationViewControllerDemo* demo = [_viewControllerList objectForKey:@"AnnotationViewControllerDemo"];
    [self.navigationController pushViewController:demo animated:YES];
}

-(IBAction)polylineButtonEvent:(id)sender
{
    PolylineViewControllerDemo* demo = [_viewControllerList objectForKey:@"PolylineViewControllerDemo"];
    [self.navigationController pushViewController:demo animated:YES];
}

-(IBAction)polygonButtonEvent:(id)sender
{
    PolygonViewControllerDemo* demo = [_viewControllerList objectForKey:@"PolygonViewControllerDemo"];
    [self.navigationController pushViewController:demo animated:YES];
}

-(IBAction)circleButtonEvent:(id)sender
{
    CircleViewControllerDemo* demo = [_viewControllerList objectForKey:@"CircleViewControllerDemo"];
    [self.navigationController pushViewController:demo animated:YES];
}

-(IBAction)poiSearchButtonEvent:(id)sender
{
    PoiSearchViewControllerDemo* demo = [_viewControllerList objectForKey:@"PoiSearchViewControllerDemo"];
    [self.navigationController pushViewController:demo animated:YES];
}

-(IBAction)roundSearchButtonEvent:(id)sender
{
    RoundSearchViewControllerDemo* demo = [_viewControllerList objectForKey:@"RoundSearchViewControllerDemo"];
    [self.navigationController pushViewController:demo animated:YES];
}

-(IBAction)busRouteSearchButtonEvent:(id)sender
{
    BusRouteSearchViewControllerDemo* demo = [[BusRouteSearchViewControllerDemo alloc] initWithNibName:@"BusRouteSearchViewControllerDemo" bundle:nil];
    [self.navigationController pushViewController:demo animated:YES];
}

-(IBAction)driveRouteSearchButtonEvent:(id)sender
{
    DriveRouteSearchViewControllerDemo* demo = [_viewControllerList objectForKey:@"DriveRouteSearchViewControllerDemo"];
    [self.navigationController pushViewController:demo animated:YES];
}

-(IBAction)buslineSearchButtonEvent:(id)sender
{
    BusLineViewControllerDemo* demo = [_viewControllerList objectForKey:@"BusLineViewControllerDemo"];
    [self.navigationController pushViewController:demo animated:YES];
}

-(IBAction)geocoderButtonEvent:(id)sender
{
    GeocodeViewControllerDemo* demo = [_viewControllerList objectForKey:@"GeocodeViewControllerDemo"];
    [self.navigationController pushViewController:demo animated:YES];
}

-(IBAction)reverseGeocodercircleButtonEvent:(id)sender
{
     ReverseGeocoderViewControllerDemo* demo = [_viewControllerList objectForKey:@"ReverseGeocoderViewControllerDemo"];
    [self.navigationController pushViewController:demo animated:YES];
}

-(IBAction)smartTripsEvent:(id)sender
{
    SmartTripsViewControllerDemo* demo = [_viewControllerList objectForKey:@"SmartTripsViewControllerDemo"];
    [self.navigationController pushViewController:demo animated:YES];
}


@end
