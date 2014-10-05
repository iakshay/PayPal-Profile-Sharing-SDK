//
//  PayPalViewController.h
//
//  Created by Rohan Aurora on 9/13/14.
//  Copyright (c) 2014 Rohan Aurora. All rights reserved.
//

#import <UIKit/UIKit.h>

// This protocol acts as a listener when the login is successful (upon generation of auth code)

@protocol LoginStatusDelegate <NSObject>
@required

-(void)success;

@end

@interface PayPalViewController : UIViewController

@property (nonatomic, weak) id <LoginStatusDelegate> delegate;

@end
