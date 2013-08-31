//
//  StreetViewViewController.h
//  SOSOStreetViewMapAPI
//
//  Created by lv wei on 13-3-26.
//  Copyright (c) 2013年 lv wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QStreetViewKit.h"
#import "QMapKit.h"
#import "QReverseGeocoder.h"

@interface StreetViewViewController : UIViewController<QStreetViewDelegate,
QReverseGeocoderDelegate>

@property(nonatomic,retain) QStreetView* streetView;
@property(nonatomic,retain) QReverseGeocoder* reverseGeocoder;

- (IBAction)newStreetViewEvent:(id)sender;
- (IBAction)destroyStreetViewEvent:(id)sender;
- (IBAction)addStreetViewOverlayEvent:(id)sender;
- (IBAction)removeStreetViewOverlayEvent:(id)sender;

@end
