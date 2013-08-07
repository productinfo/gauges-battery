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
    SGauge *gauge;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    gauge = [[SGaugeLinear alloc] initWithFrame:CGRectMake(0, 0, 400, 150) fromMinimum:@0 toMaximum:@100];
    gauge.center = self.view.center;
    gauge.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:gauge];
    
    //Background
    gauge.style.primaryBackgroundColor = [UIColor colorWithWhite:1 alpha:1];
    gauge.style.secondaryBackgroundColor = [UIColor colorWithWhite:0 alpha:1];
    gauge.style.innerRadiusProportion = 1;
    gauge.style.bevelWidth = 5;
    
    //Apply range colors
    gauge.qualitativeRanges = @[[SGaugeQualitativeRange rangeWithMinimum:@0 withMaximum:@100 withColor:[UIColor colorWithHexString:@"00ED2F" andAlpha:0.6]]];
    gauge.style.qualitativeRangeBorderColor = [UIColor clearColor];
    gauge.style.qualitativeInnerRadius = 0;
    gauge.style.qualitativeOuterRadius = 1;
 
    //Remove needle from view
    gauge.style.needleBorderWidth = 0;
    gauge.style.knobBorderWidth = 0;
    gauge.style.needleWidth = 0;
    
    //Remove axis from view
    gauge.style.showTickLabels = NO;
    gauge.style.majorTickSize = CGSizeZero;
    gauge.style.minorTickSize = CGSizeZero;
    
    //Clip the range at the needle
    gauge.colorActiveSegment = YES;
    
    //Observe the battery level
    [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBatteryStatus) name:UIDeviceBatteryLevelDidChangeNotification object:nil];
    
    //Trigger the value for the initial render
    [self updateBatteryStatus];
}

-(void)updateBatteryStatus
{
    gauge.value = [UIDevice currentDevice].batteryLevel * 100;
}

@end
