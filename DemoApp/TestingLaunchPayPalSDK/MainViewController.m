//
//  MainViewController.m
//  TestingLaunchPayPalSDK
//
//  Created by Rohan Aurora on 9/21/14.
//  Copyright (c) 2014 Rohan Aurora. All rights reserved.
//

#import "MainViewController.h"
#import "PayPalViewController.h"

@implementation MainViewController

-(void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    PayPalViewController *ppVC = [PayPalViewController new];
    [ppVC getUserAuthorizationForProfileSharing];

}

@end
