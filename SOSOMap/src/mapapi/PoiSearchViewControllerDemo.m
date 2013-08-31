//
//  PoiSearchViewControllerDemo.m
//  SOSOMapAPIDemo
//
//  Created by wei lv on 12-8-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PoiSearchViewControllerDemo.h"

@interface PoiSearchViewControllerDemo ()

- (void)showAlertView:(NSString*)title widthMessage:(NSString*)message;

@end

@implementation PoiSearchViewControllerDemo
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
    _mapView.delegate = self;
    
    QSearch* search = [[QSearch alloc] init];
    search.delegate = self;
    self.search = search;
    [search release];
    BOOL res = [_search poiSearchInCity:@"北京" withKey:@"中国技术交易大厦" pageIndex:0];
    NSLog(@"get res %i",res);
    //[_search poiSearchInCity:@"北京" withKey:@"海淀" pageIndex:0];
    //[_search poiSearchInCity:@"北京" withKey:@"温馨人家" pageIndex:0];
}

- (void)notifyPoiSearchResult:(QPoiSearchResult *)poiSearchResult
{
    QErrorCode errorCode =[poiSearchResult errorCode];
    
    if (errorCode == QPoiSearchResultPoiList) {
        
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
            
            QPointAnnotation* ann = [[QPointAnnotation alloc] init];
            ann.coordinate = info.coordinate;
            ann.title = info.name;
            ann.subtitle = info.address;
            [_mapView addAnnotation:ann];
            [ann release];
        }
        
        if (count > 0) {
            QPoiInfo* info = [poiList objectAtIndex:0];
            
            _mapView.centerCoordinate = info.coordinate;
            
            _mapView.region = QCoordinateRegionMake(info.coordinate, 
                                                    QCoordinateSpanMake(0.001, 0.001));
        }
        
        [self showAlertView:@"poiList" widthMessage:msg];
        [msg release];
    }
    else if (errorCode == QPoiSearchResultCity) {
        
        QPoiInfo* poiData = (QPoiInfo*)[poiSearchResult data];
        
        NSString* msg = [NSString stringWithFormat:@"poiData:name=%@,addr=%@,coor={%f,%f}",
                         poiData.name,
                         poiData.address,
                         poiData.coordinate.longitude,
                         poiData.coordinate.latitude];
        
        
        [self showAlertView:@"----poiresult----" widthMessage:msg];
    }
    else if (errorCode == QPoiSearchResultCrossCityList) {
        
        NSArray* cityList = (NSArray*)[poiSearchResult data];
        
        NSMutableString* msg = [[NSMutableString alloc] init];
        NSInteger count = 0;
        for (QCityInfoForPoi* info in cityList) {
            
            [msg appendFormat:@"%d.province:%@,cityName =%@,poiNum = %d\n",count,info.provinceName,info.name,info.poiNum];
            ++count;
        }
        
        [self showAlertView:@"citylist" widthMessage:msg];
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
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    
    _mapView.delegate = nil;
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
