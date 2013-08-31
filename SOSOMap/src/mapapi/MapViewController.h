//
//  ViewController.h
//  SOSOMapAPIDemo
//
//  Created by wei lv on 12-7-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QMapKit.h"
#import "QSearch.h"
#import "QAppKeyCheck.h"

@class AnnotationViewControllerDemo;
@class CircleViewControllerDemo;
enum TOverlayIdx {
    EPolylineIdx = 0,
    EPolygonIdx,
    ECircleIdx,
};

enum TAnnotationIdx {
    EAnnotationZeroIdx = 0,
    EAnnotationOneIdx = 1,

};

@interface MapViewController : UIViewController<QMapViewDelegate, QAppKeyCheckDelegate>
{
    IBOutlet UIButton* mapBtn;
    IBOutlet UIButton* locationBtn;
    IBOutlet UIButton* trafficBtn;
    IBOutlet UIButton* annotationBtn;
    IBOutlet UIButton* polylineBtn;
    IBOutlet UIButton* polygonBtn;
    IBOutlet UIButton* circleBtn;
    
    IBOutlet UIButton* poiSearchBtn;
    IBOutlet UIButton* roundSearchBtn;
    IBOutlet UIButton* busRouteSearchBtn;
    IBOutlet UIButton* driveRouteSearchBtn;
    IBOutlet UIButton* buslineSearchBtn;
    IBOutlet UIButton* geocoderBtn;
    IBOutlet UIButton* reverseGeocoderBtn;
    QAppKeyCheck* _appKeyCheck;
}

@property(nonatomic,retain) IBOutlet UIButton* mapBtn;
@property(nonatomic,retain) IBOutlet UIButton* locationBtn;
@property(nonatomic,retain) IBOutlet UIButton* trafficBtn;

@property(nonatomic,retain) IBOutlet UIButton* annotationBtn;
@property(nonatomic,retain) IBOutlet UIButton* polylineBtn;
@property(nonatomic,retain) IBOutlet UIButton* polygonBtn;
@property(nonatomic,retain) IBOutlet UIButton* circleBtn;

@property(nonatomic,retain) IBOutlet UIButton* poiSearchBtn;
@property(nonatomic,retain) IBOutlet UIButton* roundSearchBtn;
@property(nonatomic,retain) IBOutlet UIButton* busRouteSearchBtn;
@property(nonatomic,retain) IBOutlet UIButton* driveRouteSearchBtn;
@property(nonatomic,retain) IBOutlet UIButton* buslineSearchBtn;
@property(nonatomic,retain) IBOutlet UIButton* geocoderBtn;
@property(nonatomic,retain) IBOutlet UIButton* reverseGeocoderBtn;

-(IBAction)mapButtonEvent:(id)sender;
-(IBAction)locationButtonEvent:(id)sender;
-(IBAction)trafficButtonEvent:(id)sender;
-(IBAction)annotationButtonEvent:(id)sender;
-(IBAction)polylineButtonEvent:(id)sender;
-(IBAction)polygonButtonEvent:(id)sender;
-(IBAction)circleButtonEvent:(id)sender;

-(IBAction)poiSearchButtonEvent:(id)sender;
-(IBAction)roundSearchButtonEvent:(id)sender;
-(IBAction)busRouteSearchButtonEvent:(id)sender;
-(IBAction)driveRouteSearchButtonEvent:(id)sender;
-(IBAction)buslineSearchButtonEvent:(id)sender;
-(IBAction)geocoderButtonEvent:(id)sender;
-(IBAction)reverseGeocodercircleButtonEvent:(id)sender;
-(IBAction)smartTripsEvent:(id)sender;


@end
