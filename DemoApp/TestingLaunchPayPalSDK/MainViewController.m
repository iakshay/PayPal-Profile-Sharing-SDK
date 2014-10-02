//
//  MainViewController.m
//  TestingLaunchPayPalSDK
//
//  Created by Rohan Aurora on 9/21/14.
//  Copyright (c) 2014 Rohan Aurora. All rights reserved.
//

#import "MainViewController.h"
#import "NextViewController.h"
#import "PayPalViewController.h"

@implementation MainViewController

-(void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    UIButton* testButn = [UIButton buttonWithType:UIButtonTypeCustom];
    [testButn setFrame:CGRectMake(130, 195, 70, 45)];
    [testButn setImage:[UIImage imageNamed:@"BuyButton"] forState:UIControlStateNormal];
    [testButn setImage:[UIImage imageNamed:@"BuyButton"]   forState:UIControlStateSelected];
    [testButn addTarget:self action:@selector(openPayPalViewController) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:testButn];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"Main View Controller"];
    
}


-(void) openPayPalViewController {
    
    PayPalViewController *ppVC = [PayPalViewController new];
    [ppVC getUserPayPalAuthorization:self completion:^(BOOL success) {
        NSLog(@"Success Value: %d", success);
        
        if (success) {
            [self goToNextViewController];
        } else {
            NSLog(@"Fail. Reload PayPal Login.");
        }
    }];
}


// Transition to Next View Controller

-(void) goToNextViewController {
    
    NextViewController *nextVC = [[NextViewController alloc] init];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.2;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:nextVC animated:NO];
    
}

@end
