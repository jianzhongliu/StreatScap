//
//  ViewController.h
//  SOSOStreetViewMapAPI
//
//  Created by lv wei on 13-3-25.
//  Copyright (c) 2013年 lv wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QAppKeyCheck.h"
#import "QStreetViewKit.h"

@interface StreetViewController : UIViewController
{
}

@property(nonatomic,retain) IBOutlet UIButton* streetViewBtn;
@property(nonatomic,retain) IBOutlet UIButton* overViewBtn;


-(IBAction)streetViewButtonEvent:(id)sender;

-(IBAction)overViewButtonEvent:(id)sender;

@end
