//
//  RoundSearchViewControllerDemo.m
//  SOSOMapAPIDemo
//
//  Created by wei lv on 12-8-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RoundSearchViewControllerDemo.h"
#import "QPoiSearch.h"
#import "QTypes.h"

@interface RoundSearchViewControllerDemo ()

- (void)showAlertView:(NSString*)title widthMessage:(NSString*)message;
@end

@implementation RoundSearchViewControllerDemo
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
    _mapView.delegate = self;

    QSearch* search = [[QSearch alloc] init];
    search.delegate = self;
    self.search = search;
    [search release];
    
    [_search roundSearch:@"北京市" location:CLLocationCoordinate2DMake(39.908716,116.397529)
    inRadius:2000 withKey:@"公交" pageIndex:4];
}

- (void)notifyPoiSearchResult:(QPoiSearchResult *)poiSearchResult
{
    QErrorCode errorCode =[poiSearchResult errorCode];
    
    if (errorCode == QPoiSearchResultRoundPoi) {
        
        QPoiData* poiData = (QPoiData*)[poiSearchResult data];
        
        NSMutableString* msg = [[NSMutableString alloc] init];
        
        [msg appendFormat:@"totalPoiNum:%d,curPoiNum:%d,pageNum = %d,pageIndex = %d\n",
         poiData.totalPoiNum,
         poiData.curPoiNum,
         poiData.pageNum,
         poiData.pageIndex];
        
        
        NSArray* poiList = [poiData poiInfoList];
        
        NSInteger count = 0;
        for (QPoiInfo* info in poiList) {
            
            [msg appendFormat:@"%d:title=%@,subTitle = %@,{%f,%f}\n",
             count,
             info.name,
             info.address,
             info.coordinate.longitude,
             info.coordinate.latitude];
            ++count;
            
            QPointAnnotation* annotation = [[QPointAnnotation alloc] init];
            annotation.coordinate = info.coordinate;
            annotation.title = info.name;
            annotation.subtitle = info.address;
            [_mapView addAnnotation:annotation];
            [annotation release];
        }
        
        if (count > 0) {
            QPoiInfo* info = [poiList objectAtIndex:0];
            
            _mapView.centerCoordinate = info.coordinate;
            
            _mapView.region = QCoordinateRegionMake(info.coordinate, 
                                                    QCoordinateSpanMake(0.01, 0.01));
        }
        
        [self showAlertView:@"poiList" widthMessage:msg];
        [msg release];
    }
}

- (QAnnotationView *)mapView:(QMapView *)mapView viewForAnnotation:(id <QAnnotation>)annotation
{
	if ([annotation isKindOfClass:[QPointAnnotation class]]) {
        static NSString* reuseIdentifier = @"annotation";
        
        QPinAnnotationView* newAnnotation = (QPinAnnotationView*)[_mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
        
        if (nil == newAnnotation) {
            newAnnotation = [[[QPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIdentifier] autorelease]; 
        }
        
		newAnnotation.pinColor = QPinAnnotationColorGreen;   
		newAnnotation.animatesDrop = YES;
        newAnnotation.canShowCallout = YES;
		
		return newAnnotation;   
	}
	return nil;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    _search.delegate = nil;
    self.search = nil;
    
    _mapView.delegate = nil;
    self.mapView = nil;
}

- (void)dealloc
{
    _search.delegate = nil;
    self.search = nil;
    
    _mapView.delegate = nil;
    self.mapView = nil;
    
    [super dealloc];
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
