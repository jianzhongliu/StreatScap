//
//  DriveRouteSearchViewControllerDemo.m
//  SOSOMapAPIDemo
//
//  Created by wei lv on 12-8-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DriveRouteSearchViewControllerDemo.h"
#import "QRouteSearch.h"
#import "QTypes.h"

@interface DriveRouteSearchViewControllerDemo ()
- (void)showAlertView:(NSString*)title widthMessage:(NSString*)message;

@end

@implementation DriveRouteSearchViewControllerDemo
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
    //此处主要是将路线全部调整到视野范围内
    CLLocationCoordinate2D newCoordinate = _mapView.centerCoordinate;
    newCoordinate.latitude -= 8;
    _mapView.region = QCoordinateRegionMake(newCoordinate, QCoordinateSpanMake(10,10));
    QSearch* search = [[QSearch alloc] init];
    search.delegate = self;
    self.search = search;
    [search release];
    
    [_search drivingSearch:@"北京市" start:@"中华民族园" endCity:@"汕头市" end:@"亭桥"
       withDriveSearchType:QDriveSearchShortCut];
}

- (void)notifyRouteSearchResult:(QRouteSearchResult *)routeSearchResult
{
    QErrorCode errCode = [routeSearchResult errorCode];
    
    if (errCode == QRouteSearchResultDriveList) {
        
        NSMutableString* msg = [[NSMutableString alloc] init];
        [msg appendString:@"start:\n"];
        
        QRouteQueryResultChoice* choice = (QRouteQueryResultChoice*)[routeSearchResult data];
        
        NSInteger count = 0;
        for (QPlaceInfo* info in [choice startList]) {
            
            [msg appendFormat:@"%d.name=%@,address=%@,coor={%lf,%lf}\n",count,
             info.name,info.address,info.coordinate.longitude,info.coordinate.latitude];
            ++count;
        }
        
        [msg appendString:@"end:\n"];
        
        count = 0;
        for (QPlaceInfo* info in [choice endList]) {
            
            [msg appendFormat:@"%d.name=%@,address=%@,coor={%lf,%lf}\n",
             count,info.name,info.address,info.coordinate.longitude,info.coordinate.latitude];
            ++count;
        }
        
        [self showAlertView:@"choice list" widthMessage:msg];
        [msg release];
        
        /*
         出现选择列表时，可以选取完起终点再进行进一步搜索，类似下述做法 
          */
         NSArray* startList = choice.startList;
         NSArray* endList = choice.endList;
         
         if (startList.count > 0 && endList.count > 0 ) {
        
             [_search drivingSearchWithLocation:@"北京"
                                          start:  [startList objectAtIndex:0]
                                        endCity:@"北京"
                                            end:[endList objectAtIndex:0]
                            withDriveSearchType:QDriveSearchShortCut];
         }
       
    }
    else if (errCode == QRouteSearchResultDriveResult) {
        QRouteInfoForDrive* routeInfoForDrive = [routeSearchResult data];
        
        QPointAnnotation* pa = [[QPointAnnotation alloc] init];
        pa.coordinate = routeInfoForDrive.start.coordinate;
        pa.title = [NSString stringWithFormat:@"起点:%@",routeInfoForDrive.start.name];
        [_mapView addAnnotation:pa];
        [pa release];
        
        pa = [[QPointAnnotation alloc] init];
        pa.coordinate = routeInfoForDrive.end.coordinate;
        pa.title = [NSString stringWithFormat:@"终点:%@",routeInfoForDrive.end.name];
        [_mapView addAnnotation:pa];
        [pa release];
        
        QPolyline* pl = [QPolyline polylineWithCoordinates:routeInfoForDrive.routeNodeList
                                                     count:routeInfoForDrive.routeNodeCount];
        
        [_mapView addOverlay:pl];
        
    }
}


-(QOverlayView*)mapView:(QMapView *)mapView viewForOverlay:(id<QOverlay>)overlay
{
    if ([overlay isKindOfClass:[QPolyline class]]) {
        
        QPolylineView* polylineView = [[QPolylineView alloc] initWithPolyline:overlay];
        
        polylineView.lineWidth = 2.0;
		polylineView.strokeColor = [UIColor redColor] ;//[[UIColor redColor] colorWithAlphaComponent:0.5];
        
        return [polylineView autorelease];
    }
    
    return nil;
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
    
    _mapView.delegate = nil;
    self.mapView = nil;
    
    _search.delegate = nil;
    [_search release];
    _search = nil;
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
