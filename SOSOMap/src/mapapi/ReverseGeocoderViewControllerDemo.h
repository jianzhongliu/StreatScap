//
//  ReverseGeocoderViewControllerDemo.h
//  SOSOMapAPIDemo
//
//  Created by wei lv on 12-8-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "QMapKit.h"

@interface ReverseGeocoderViewControllerDemo : UIViewController<QMapViewDelegate,
QReverseGeocoderDelegate>
{
    IBOutlet QMapView* _mapView;
    QReverseGeocoder* _reverseGeocoder;
}

@property(nonatomic, retain) IBOutlet QMapView* mapView;
@property(nonatomic, retain) QReverseGeocoder* reverseGeocoder;

@end
