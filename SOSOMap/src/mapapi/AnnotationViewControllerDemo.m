//
//  AnnotationViewControllerDemo.m
//  SOSOMapAPIDemo
//
//  Created by wei lv on 12-7-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AnnotationViewControllerDemo.h"

@interface AnnotationViewControllerDemo ()

@end

@implementation AnnotationViewControllerDemo
@synthesize mapView = _mapView;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//        
//      
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
	_mapView.delegate = self;
    
    QPointAnnotation* annotation = [[QPointAnnotation alloc]init];
    [annotation setCoordinate:CLLocationCoordinate2DMake(39.908716, 116.397529)];
    [annotation setTitle:@"银科大厦"];
    [annotation setSubtitle:@"北京市区海淀区苏州街银科大厦"];
    [_mapView addAnnotation:annotation];
    [annotation release];

}

- (QAnnotationView *)mapView:(QMapView *)mapView viewForAnnotation:(id <QAnnotation>)annotation
{
	if ([annotation isKindOfClass:[QPointAnnotation class]]) {
        static NSString* reuseIdentifier = @"annotation";
        
        QPinAnnotationView* newAnnotation = (QPinAnnotationView*)[_mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
        
        if (nil == newAnnotation) {
            newAnnotation = [[QPinAnnotationView alloc] 
                              initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
            
            [newAnnotation autorelease];
        }
        
		newAnnotation.pinColor = QPinAnnotationColorRed;   
		newAnnotation.animatesDrop = YES;
        newAnnotation.canShowCallout = YES;
		
		return newAnnotation;   
	}
	return nil;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.mapView = nil;
}

- (void)dealloc
{
    [_mapView release];
    _mapView = nil;
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
