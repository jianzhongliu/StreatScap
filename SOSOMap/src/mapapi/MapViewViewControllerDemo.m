//
//  MapViewViewControllerDemo.m
//  SOSOMapAPIDemo
//
//  Created by wei lv on 12-7-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MapViewViewControllerDemo.h"

@interface MapViewViewControllerDemo ()

@end

@implementation MapViewViewControllerDemo
@synthesize mapView = _mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    NSLog(@"get view unload ");
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.mapView = nil;
}

- (void)dealloc
{
    
    NSLog(@"get view dealloc ");
    [_mapView release];
    _mapView = nil;
    
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
