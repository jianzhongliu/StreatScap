//
//  GeocodeViewControllerDemo.h
//  SOSOMapAPIDemo
//
//  Created by wei lv on 12-7-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QMapKit.h"
#import "QGeocoder.h"

@interface GeocodeViewControllerDemo : UIViewController<QMapViewDelegate,
                                        QGeocoderDelegate>
{
    IBOutlet QMapView* _mapView;
    QGeocoder* _geocoder;
}

@property(nonatomic, retain) IBOutlet QMapView* mapView;
@property(nonatomic, retain) QGeocoder* geocoder;

@end
