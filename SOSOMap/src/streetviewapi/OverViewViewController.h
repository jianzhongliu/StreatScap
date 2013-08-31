//
//  OverViewViewController.h
//  SOSOStreetViewMapAPI
//
//  Created by lv wei on 13-3-26.
//  Copyright (c) 2013年 lv wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QStreetViewKit.h"
#import "QMapKit.h"

@interface OverViewViewController : UIViewController<QReverseGeocoderDelegate,QOverViewRequestDelegate>

@property(nonatomic, retain) QReverseGeocoder* streetViewPoiRequest;
@property(nonatomic, retain) IBOutlet UIImageView* overViewImageView;
@property(nonatomic, retain) QOverViewRequest* overViewRequest;

@end
