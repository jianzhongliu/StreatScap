//
//  ViewController.m
//  SOSOMap
//
//  Created by yons on 13-8-31.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import "ViewController.h"
#import <mach/mach_time.h>
#import "StreetViewViewController.h"
#import "QStreetView.h"

@interface ViewController ()
{
    double _x;
    double _y;
}
@end

@implementation ViewController
@synthesize appKeyCheck = _appKeyCheck;
@synthesize streetView = _streetView;
@synthesize reverseGeocoder = _reverseGeocoder;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    QAppKeyCheck* check = [[QAppKeyCheck alloc] init];
    [check start:@"99bfda1eebb2b9cdb9bc0993bf345743" withDelegate:self];
    self.appKeyCheck = check;
    [check release];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - QAppKeyCheckDelegate
- (void)notifyAppKeyCheckResult:(QErrorCode)errCode
{
    NSLog(@"errcode = %d",errCode);
    printf("ILOve you!");
    
    if (errCode == QErrorNone) {
        NSLog(@"恭喜您，APPKey验证通过！");
        
        CLLocationCoordinate2D l1 = CLLocationCoordinate2DMake(31.219839,121.526017);
        //CLLocationCoordinate2D l1 = CLLocationCoordinate2DMake(39.988917, 116.422806);
        //CLLocationCoordinate2D l1 = CLLocationCoordinate2DMake(22.524896, 113.925659);
        //CLLocationCoordinate2D l1 = CLLocationCoordinate2DMake(0, 113.925659);
        QReverseGeocoder* r = [[QReverseGeocoder alloc] initWithCoordinate:l1];
        r.delegate = self;
        self.reverseGeocoder = r;
        r.radius = 100;
        [r start];
        [r release];
        
        QStreetView* sv = [[QStreetView alloc] initWithFrame:self.view.frame];
        sv.delegate = self;
        sv.isSupportMotionManager = YES;
        self.streetView = sv;
        [self.view addSubview:sv];
        [sv release];
    }
    else if(errCode == QNetError)
    {
        [self showAlertView:@"AppKey验证结果" widthMessage:@"网络好像不太给力耶！请检查下网络是否畅通?"];
    }
    else if(errCode == QAppKeyCheckFail)
    {
        [self showAlertView:@"AppKey验证结果" widthMessage:@"您的APPKEY好像是有问题喔，请检查下APPKEY是否正确？"];
    }
}

#pragma mark - reservegeocorderDelegate
- (void)reverseGeocoder:(QReverseGeocoder *)geocoder didFindPlacemark:(QPlaceMark *)placeMark
{
    NSLog(@"reverseGeocoder!");
    [_streetView showStreetView:placeMark];
//    _x = placeMark.coordinate.longitude;
//    _y = placeMark.coordinate.latitude;
//    _index = -1;
}

- (void)reverseGeocoder:(QReverseGeocoder *)geocoder didFailWithError:(QErrorCode)error
{
    NSLog(@"streetView  request fail! = %d",error);
}

- (void)streetView:(QStreetView *)streetview streetViewInfo:(QStreetViewInfo *)streetViewInfo
{
    switch (streetViewInfo.streetViewInfoType) {
        case QStreetViewInfoInit:
        case QStreetViewInfoSceneChange:{
            break;
        }
        default:
            break;
    }
}

- (void)streetView:(QStreetView *)streetview streetViewShowState:(QStreetViewShowState)streetViewShowState
{
    switch (streetViewShowState) {
        case QStreetViewShowThumbMap: {
            
            break;
        }
        default:
            break;
    }
    //NSLog(@"streetViewShowState = %d",streetViewShowState);
}

#pragma mark - privateMethods
- (void)showAlertView:(NSString*)title widthMessage:(NSString*)message
{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView sizeToFit];
	[alertView show];
	[alertView release];
    mach_timebase_info_data_t info;
    mach_timebase_info(&info);
    //    uint64_t start = mach_absolute_time();
    UIImage * image = [UIImage imageNamed:@"pin_yellow.png"];
    //    image.
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width/2,image.size.height/2));
    [image drawInRect:CGRectMake(0,0,image.size.width/2,image.size.height/2)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
}

@end
