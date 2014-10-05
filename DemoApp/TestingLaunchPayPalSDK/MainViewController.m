//
//  MainViewController.m
//  TestingLaunchPayPalSDK
//
//  Created by Rohan Aurora on 9/21/14.
//  Copyright (c) 2014 Rohan Aurora. All rights reserved.
//

#import "MainViewController.h"
#import "NextViewController.h"

@implementation MainViewController 

-(void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    UIButton* testButn = [UIButton buttonWithType:UIButtonTypeCustom];
    [testButn setFrame:CGRectMake(90, 205, 150, 55)];
    [testButn setImage:[UIImage imageNamed:@"loginwithpaypalbutton"] forState:UIControlStateNormal];
    [testButn setImage:[UIImage imageNamed:@"loginwithpaypalbutton"]   forState:UIControlStateSelected];
    [testButn addTarget:self action:@selector(openPayPalViewController) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:testButn];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"Main View Controller"];
    
    
}

// Present PayPal login screen from SDK
-(void) openPayPalViewController {
    
    PayPalViewController *ppVC = [PayPalViewController new];
    [ppVC setDelegate:self];
    [self presentViewController:ppVC animated:YES completion:nil];

}


// Use delegate protocol
-(void)success {
    
    NSLog(@"Login successful.");
    [self goToNextViewController];
}


// Transition to Next View Controller
-(void) goToNextViewController {
    
    NextViewController *nextVC = [[NextViewController alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

@end
