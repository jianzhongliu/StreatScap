//
//  ReverseGeocoderViewControllerDemo.m
//  SOSOMapAPIDemo
//
//  Created by wei lv on 12-8-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ReverseGeocoderViewControllerDemo.h"

@interface ReverseGeocoderViewControllerDemo ()

@end

@implementation ReverseGeocoderViewControllerDemo
@synthesize mapView = _mapView;
@synthesize reverseGeocoder = _reverseGeocoder;

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
    CLLocationCoordinate2D coor;
    coor.longitude = 116.397529;
    coor.latitude = 39.908716;
    
    QReverseGeocoder* geocode = [[QReverseGeocoder alloc] initWithCoordinate:coor];
    geocode.delegate = self;
    self.reverseGeocoder = geocode;
    [geocode release];
    
    [_reverseGeocoder start];
}

- (void)reverseGeocoder:(QReverseGeocoder *)geocoder didFindPlacemark:(QPlaceMark *)placeMark
{
    QPointAnnotation* annotation = [[QPointAnnotation alloc] init];
    annotation.coordinate = geocoder.coordinate;
    annotation.title = placeMark.name;
    if (placeMark.address) {
        annotation.subtitle = placeMark.address;
    }
    
    [_mapView addAnnotation:annotation];
    [annotation release];
}

- (QAnnotationView *)mapView:(QMapView *)mapView viewForAnnotation:(id <QAnnotation>)annotation
{
 	if ([annotation isKindOfClass:[QPointAnnotation class]]) {
        static NSString* reuseIdentifier = @"annotation_1";
        
        QPinAnnotationView* annotationView = (QPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
        
        if (nil == annotationView) {
            annotationView = [[[QPinAnnotationView alloc] 
                               initWithAnnotation:annotation reuseIdentifier:reuseIdentifier] autorelease]; 
        }
        
		annotationView.pinColor = QPinAnnotationColorRed;   
		annotationView.animatesDrop = YES;
        annotationView.canShowCallout = YES;
		
		return annotationView;   
	}
	return nil;
}

- (void)reverseGeocoder:(QReverseGeocoder *)geocoder didFailWithError:(QErrorCode) error
{
    //deal 
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    _mapView.delegate = nil;
    self.mapView = nil;
    _reverseGeocoder.delegate = nil;
    self.reverseGeocoder = nil;
}

- (void)dealloc
{
    _mapView.delegate = nil;
    self.mapView = nil;
    _reverseGeocoder.delegate = nil;
    self.reverseGeocoder = nil;
    
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



@end
