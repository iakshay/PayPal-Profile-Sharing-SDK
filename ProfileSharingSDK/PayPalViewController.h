//
//  PayPalViewController.h
//  NativeApp
//
//  Created by Rohan Aurora on 9/13/14.
//  Copyright (c) 2014 Rohan Aurora. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PayPalViewController : UIViewController

-(void)getUserPayPalAuthorization:(UIViewController *)presentingViewController completion:(void (^)(BOOL success))handler;

@end
