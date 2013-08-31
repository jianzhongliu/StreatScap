//
//  TrafficViewControllerDemo.h
//  SOSOMapAPIDemo
//
//  Created by wei lv on 12-7-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QMapKit.h"

@interface TrafficViewControllerDemo : UIViewController
{
    IBOutlet QMapView* _mapView;
}

@property(nonatomic,retain)QMapView* mapView;

@end
