//
//  OverViewViewController.m
//  SOSOStreetViewMapAPI
//
//  Created by lv wei on 13-3-26.
//  Copyright (c) 2013年 lv wei. All rights reserved.
//

#import "OverViewViewController.h"

@interface OverViewViewController ()

@end

@implementation OverViewViewController
@synthesize streetViewPoiRequest = _streetViewPoiRequest;
@synthesize overViewImageView = _overViewImageView;
@synthesize overViewRequest = _overViewRequest;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#define kDefaultLatitude 21
#define kDefaultLintitude 121
- (void)viewDidLoad
{
    [super viewDidLoad];
    CLLocationCoordinate2D l1 = CLLocationCoordinate2DMake(21, 121);
    QReverseGeocoder* r = [[QReverseGeocoder alloc] initWithCoordinate:l1];
    r.radius = 100000;
    r.delegate = self;
    
    self.streetViewPoiRequest = r;
    [r start];
    [r release];
}

- (void)dealloc
{
    _streetViewPoiRequest.delegate = nil;
    [_streetViewPoiRequest release];
    [_overViewImageView release];
    
    _overViewRequest.delegate = nil;
    [_overViewRequest release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reverseGeocoder:(QReverseGeocoder *)geocoder didFindPlacemark:(QPlaceMark *)placeMark
{
    QOverViewRequest* r = [[QOverViewRequest alloc] init];
    r.delegate = self;
    [r start:placeMark];
    self.overViewRequest = r;
    [r release];
}


- (void)reverseGeocoder:(QReverseGeocoder *)geocoder didFailWithError:(QErrorCode)error
{
    NSLog(@"request fail");
}


- (void)overViewRequest:(QOverViewRequest *)request didFindOverViewImage:(UIImage *)overViewImage
{
    _overViewImageView.image = overViewImage;
    NSLog(@"overViewRequest request success!");
}

- (void)overViewRequest:(QOverViewRequest *)request didFailWithError:(QErrorCode)error
{
    NSLog(@"overViewRequest request fail!");
}

@end
