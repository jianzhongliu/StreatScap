//
//  RoundSearchViewControllerDemo.h
//  SOSOMapAPIDemo
//
//  Created by wei lv on 12-8-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QSearch.h"
#import "QMapKit.h"

@interface RoundSearchViewControllerDemo : UIViewController<QMapViewDelegate,QSearchDelegate>
{
    IBOutlet QMapView* _mapView;
    QSearch* _search;
}

@property(nonatomic, retain) IBOutlet QMapView* mapView;
@property(nonatomic, retain) QSearch* search;

@end
