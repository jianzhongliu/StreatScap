//
//  ViewController.h
//  SOSOMap
//
//  Created by yons on 13-8-31.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QAppKeyCheck.h"
#import "QStreetView.h"
#import "QReverseGeocoder.h"

@interface ViewController : UIViewController<QAppKeyCheckDelegate, QStreetViewDelegate, QReverseGeocoderDelegate>

@property(nonatomic, retain) QAppKeyCheck* appKeyCheck;
@property(nonatomic, retain) QStreetView* streetView;
@property(nonatomic, retain) QReverseGeocoder* reverseGeocoder;

@end
