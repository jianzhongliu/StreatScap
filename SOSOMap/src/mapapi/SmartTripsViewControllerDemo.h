//
//  SmartTripsViewController.h
//  SOSOMapAPIDemo
//
//  Created by lv wei on 12-12-21.
//
//

#import <UIKit/UIKit.h>
#import "QSearch.h"
#import "QMapKit.h"

@interface SmartTripsViewControllerDemo : UIViewController<QMapViewDelegate,QSearchDelegate>
{
        IBOutlet QMapView* _mapView;
        QSearch* _search;
}

@property(nonatomic, retain) IBOutlet QMapView* mapView;
@property(nonatomic, retain) QSearch* search;
@end
