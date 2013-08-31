//
//  TrafficViewControllerDemo.m
//  SOSOMapAPIDemo
//
//  Created by wei lv on 12-7-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TrafficViewControllerDemo.h"

@interface TrafficViewControllerDemo ()

@end

@implementation TrafficViewControllerDemo
@synthesize mapView = _mapView;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _mapView.mapType = QMapTypeTrafficOn;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    _mapView.delegate = nil;
    self.mapView = nil;
}

- (void)dealloc
{
    _mapView.delegate = nil;
    self.mapView = nil;
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
