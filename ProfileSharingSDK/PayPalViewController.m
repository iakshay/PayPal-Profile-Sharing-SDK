//
//  PayPalViewController.m
//
//  Created by Rohan Aurora on 9/13/14.
//  Copyright (c) 2014 Rohan Aurora. All rights reserved.
//

#import "PayPalViewController.h"
#import "PayPalMobile.h"

@interface PayPalViewController () <PayPalProfileSharingDelegate> {
    dispatch_once_t once;
}

@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;
@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, strong, readwrite) NSDictionary *resultText;
@property(nonatomic, strong, readwrite) NSString *authCodeString;
@property(nonatomic, strong, readwrite) NSString *code;

@end

@implementation PayPalViewController
@synthesize delegate;

#pragma mark - Method exposed in the headers (Method 1)

-(void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    
    dispatch_once(&once, ^{
        
        // Preconnect to PayPal
        
        [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentSandbox : PayPalEnvironmentNoNetwork}];
        [PayPalMobile preconnectWithEnvironment:PayPalEnvironmentNoNetwork];
        NSLog(@"Preconnected to PayPal. Success.");
        
        
        // Start profile sharing
        
        self.payPalConfig = [[PayPalConfiguration alloc] init];
        self.payPalConfig.acceptCreditCards = YES;
        self.payPalConfig.languageOrLocale = @"en";
        self.payPalConfig.merchantName = @"Anonymous Merchant";
        self.payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
        self.payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
        self.payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
        self.payPalConfig.payPalShippingAddressOption = PayPalShippingAddressOptionPayPal;
        
        NSSet *scopeValues = [NSSet setWithArray:@[kPayPalOAuth2ScopeEmail,
                                                   kPayPalOAuth2ScopeAddress,
                                                   kPayPalOAuth2ScopeOpenId,
                                                   kPayPalOAuth2ScopePhone,
                                                   ]];
        
        PayPalProfileSharingViewController *profileSharingPaymentViewController = [[PayPalProfileSharingViewController alloc] initWithScopeValues:scopeValues configuration:self.payPalConfig delegate:self];
        NSLog(@"Scopes set. Opening PayPal Login.");
        
        
        // Open PayPal's login screen
        
        [self presentViewController:profileSharingPaymentViewController animated:YES completion:nil];
        
        //      To avoid 'View is not in the window hierarchy' error
        //      Delegates fail upon using this:
        //     [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:profileSharingPaymentViewController
        //                                                                                  animated:YES
        //                                                                                completion:nil];
        
    });
}



#pragma mark Get AuthCode (Method 2)

- (void)payPalProfileSharingViewController:(PayPalProfileSharingViewController *)profileSharingViewController
             userDidLogInWithAuthorization:(NSDictionary *)profileSharingAuthorization {
    
    NSLog(@"PayPal Profile Sharing Authorization Success!");
    self.resultText = profileSharingAuthorization;
    self.authCodeString = [self.resultText valueForKeyPath:@"response.code"];
    NSLog(@"\nHere is your auth code - \n%@\n",self.authCodeString);

    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [self sendAuthCode];
    
}

#pragma mark Login Status (Method 3)

// Network call to get success keyword

-(NSString *) sendAuthCode {

    // This is a network call using self.authCodeString
    // For simplicity I am hard coding the return value to success.
    
    NSString *statusString = @"success";
    
 //   [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [delegate success];

    return statusString;
    
}


// PayPalProfileSharingDelegate method

- (void)userDidCancelPayPalProfileSharingViewController:(PayPalProfileSharingViewController *)profileSharingViewController {
    NSLog(@"PayPal Profile Sharing Authorization Canceled");
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
