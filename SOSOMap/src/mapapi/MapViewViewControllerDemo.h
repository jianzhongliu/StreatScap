//
//  MapViewViewControllerDemo.h
//  SOSOMapAPIDemo
//
//  Created by wei lv on 12-7-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QMapKit.h"

@interface MapViewViewControllerDemo : UIViewController
{
    IBOutlet QMapView* _mapView;
}

@property(nonatomic, retain)IBOutlet QMapView* mapView;

@end
