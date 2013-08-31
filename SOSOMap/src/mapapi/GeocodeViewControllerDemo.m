//
//  GeocodeViewControllerDemo.m
//  SOSOMapAPIDemo
//
//  Created by wei lv on 12-7-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GeocodeViewControllerDemo.h"

@interface GeocodeViewControllerDemo ()

@end

@implementation GeocodeViewControllerDemo
@synthesize mapView = _mapView;
@synthesize geocoder = _geocoder;

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
    _mapView.delegate = self;
    
    QGeocoder* geocode = [[QGeocoder alloc] initWithAddress:@"海淀区银科大厦"];
    geocode.delegate = self;
    
    self.geocoder = geocode;
    [geocode release];
    [_geocoder start];
}

- (void)geocoder:(QGeocoder *)geocoder didFindAddressInfo:(QAddressInfo*) addressInfo
{
    QPointAnnotation* annotation = [[QPointAnnotation alloc] init];
    annotation.coordinate = addressInfo.coordinate;
    annotation.title = geocoder.address;
    
    NSMutableString* str = [[NSMutableString alloc] init];
    
    [str appendString:addressInfo.province];
    
    if (![addressInfo.province isEqualToString:addressInfo.city]) {
        [str appendString:addressInfo.city];
    }
    
    [str appendString:addressInfo.district];
    annotation.subtitle = str;
    [str release];
    
    [_mapView addAnnotation:annotation];
    [annotation release];
}

/**失败时的通知
 *@param geocoder    QGeocoder
 *@param error       见QErrorCode
 *@return 
 */
- (void)geocoder:(QGeocoder *)geocoder didFailWithError:(QErrorCode)error
{
    //deal 
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

- (void)dealloc
{
    _mapView.delegate = nil;
    self.mapView = nil;
    _geocoder.delegate = nil;
    self.geocoder = nil;
    
    [super dealloc];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.mapView = nil;
   // self.geocoder = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




@end
