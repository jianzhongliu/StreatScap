//
//  ViewController.m
//  SOSOStreetViewMapAPI
//
//  Created by lv wei on 13-3-25.
//  Copyright (c) 2013年 lv wei. All rights reserved.
//

#import "StreetViewController.h"
#import "StreetViewViewController.h"
#import "OverViewViewController.h"

@interface StreetViewController ()
{
    NSMutableDictionary* _viewControllerList;
}

@property(nonatomic, retain)NSDictionary* viewControllerList;

@end

@implementation StreetViewController
@synthesize viewControllerList = _viewControllerList;
@synthesize streetViewBtn = _streetViewBtn;
@synthesize overViewBtn = _overViewBtn;

- (void)dealloc
{
    [_viewControllerList release];
    [_streetViewBtn release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"街景测试DEMO";
    

    
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] initWithCapacity:14];
    
    StreetViewViewController* streetViewController = [[StreetViewViewController alloc] initWithNibName:@"StreetViewViewController" bundle:nil];
    [dic setObject:streetViewController forKey:@"StreetViewViewController"];
    [streetViewController release];
    
    OverViewViewController* overViewViewController = [[OverViewViewController alloc] initWithNibName:@"OverViewViewController" bundle:nil];
    [dic setObject:overViewViewController forKey:@"OverViewViewController"];
    [overViewViewController release];
    
    self.viewControllerList = dic;
    [dic release];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    return NO;
}

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
}

-(IBAction)streetViewButtonEvent:(id)sender
{
    StreetViewViewController* demo = [_viewControllerList objectForKey:@"StreetViewViewController"];
    [self.navigationController pushViewController:demo animated:YES];
}

-(IBAction)overViewButtonEvent:(id)sender
{
    OverViewViewController* demo = [_viewControllerList objectForKey:@"OverViewViewController"];
    [self.navigationController pushViewController:demo animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
