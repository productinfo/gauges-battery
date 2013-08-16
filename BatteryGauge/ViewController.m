//
//  ViewController.m
//  BatteryGauge
//
//  Created by Thomas Kelly on 07/08/2013.
//  Copyright (c) 2013 Scott Logic. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+Hex.h"
#import <ShinobiGauges/ShinobiGauges.h>

@implementation ViewController
{
    SGaugeRadial *gauge;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    gauge = [[SGaugeRadial alloc] initWithFrame:CGRectMake(0, 0, 300, 300) fromMinimum:@0 toMaximum:@100];
    gauge.style = [SGaugeLightStyle new];
    gauge.center = self.view.center;
    gauge.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:gauge];

    //Set the angle
    gauge.arcAngleStart = -M_PI_4 * 3;
    gauge.arcAngleEnd = M_PI_4 * 3;
    
    //Gauge style
    gauge.style.borderIsFullCircle = YES;
    gauge.style.innerBackgroundColor = [UIColor colorWithHexString:@"66D8F2" andAlpha:1];
    gauge.style.outerBackgroundColor = [UIColor colorWithHexString:@"17205C" andAlpha:1];
    
    //Axis style
    gauge.style.tickBaselinePosition = 0.7;
    gauge.style.tickLabelColor = [UIColor colorWithHexString:@"3E9C62" andAlpha:1];
    gauge.style.tickLabelFont = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:18];
    gauge.style.majorTickColor = gauge.style.tickLabelColor;
    gauge.style.minorTickColor = gauge.style.tickLabelColor;
    
    //Bevel style
    gauge.style.bevelWidth = 20;
    gauge.style.bevelPrimaryColor = [UIColor colorWithHexString:@"232B5E" andAlpha:1];
    gauge.style.bevelSecondaryColor = [UIColor colorWithHexString:@"5563BD" andAlpha:1];
    
    //Needle style
    gauge.style.needleColor = [UIColor colorWithHexString:@"3FE0BD" andAlpha:1];
    gauge.style.needleWidth = 10;
    gauge.style.needleLength = 0.75;
    gauge.style.knobColor = [UIColor colorWithHexString:@"5563BD" andAlpha:1];
    gauge.style.needleBorderColor = [UIColor blackColor];
    gauge.style.needleBorderWidth = 1;

    //Observe the battery level
    [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBatteryStatus) name:UIDeviceBatteryLevelDidChangeNotification object:nil];
    
    //Trigger the value for the initial render
    [self updateBatteryStatus];
    
    //Add decorative lightning bolt
    UIImage *boltImage = [UIImage imageNamed:@"lightning.png"];
    UIImageView *bolt = [[UIImageView alloc] initWithImage:boltImage];
    bolt.center = CGPointMake(155, 120);
    [gauge addSubview:bolt];
}

-(void)updateBatteryStatus
{
    gauge.value = [UIDevice currentDevice].batteryLevel * 100;
}

@end
