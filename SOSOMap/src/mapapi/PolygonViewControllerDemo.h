//
//  PolygonViewControllerDemo.h
//  SOSOMapAPIDemo
//
//  Created by wei lv on 12-7-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QMapKit.h"

@interface PolygonViewControllerDemo : UIViewController<QMapViewDelegate>
{
    IBOutlet QMapView* mapView;
}

@property(nonatomic,retain) IBOutlet QMapView* mapView;

@end
