//
//  PayPalViewController.m
//  NativeApp
//
//  Created by Rohan Aurora on 9/13/14.
//  Copyright (c) 2014 Rohan Aurora. All rights reserved.
//

#import "PayPalViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "PayPalMobile.h"

@interface PayPalViewController () <PayPalProfileSharingDelegate>

@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;
@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, strong, readwrite) NSDictionary *resultText;
@property(nonatomic, strong, readwrite) NSString *authCodeString;
@property(nonatomic, strong, readwrite) NSString *code;

@end

@implementation PayPalViewController


#pragma mark - Method exposed in the headers (Method 1)

-(void)getUserPayPalAuthorization:(UIViewController *)presentingViewController completion:(void (^)(BOOL success))handler {
    

    // Preconnect to PayPal
    
    static NSString const *kSandboxEnvironment = @"AX1-ZxAZfMuB0a0UOIBHal9gct-Ju1qSlvsh1EB31WLJLoi0ByVWMoJRnQAZ";
    [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentSandbox : kSandboxEnvironment}];
    [PayPalMobile preconnectWithEnvironment:PayPalEnvironmentSandbox];
    NSLog(@"Preconnected to PayPal. Success.");
    
    
    // Start profile sharing
    
    self.payPalConfig = [[PayPalConfiguration alloc] init];
    self.payPalConfig.acceptCreditCards = YES;
    self.payPalConfig.languageOrLocale = @"en";
    self.payPalConfig.merchantName = @"TestEcnCheckout";
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
    NSLog(@"Scopes set. Opening PayPal Login");
    
    
    // Open PayPal's login screen
    
    UIWindow *keyWindow= [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview: profileSharingPaymentViewController.view];
    
    [self presentViewController:profileSharingPaymentViewController animated:YES completion:nil];
    
    //      To avoid 'View is not in the window hierarchy' error
    //      Delegates fail upon using this:
    //     [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:profileSharingPaymentViewController
    //                                                                                  animated:YES
    //                                                                                completion:nil];
    
}



#pragma mark Get AuthCode (Method 2)

- (void)payPalProfileSharingViewController:(PayPalProfileSharingViewController *)profileSharingViewController
             userDidLogInWithAuthorization:(NSDictionary *)profileSharingAuthorization {
    
    NSLog(@"PayPal Profile Sharing Authorization Success!");
    self.resultText = profileSharingAuthorization;
    self.authCodeString = [self.resultText valueForKeyPath:@"response.code"];
    NSLog(@"Here is your auth code - \n\n%@\n",self.authCodeString);
    
}

#pragma mark Login Status (Method 3)

-(void) getLoginStatus {
    
    // To be used in Handler
    // Check output from from network call
    NSString *intercept = [self sendAuthCode];
    
    if ([intercept isEqual: @"success"]) {
        NSLog(@" ____________________________ SUCCESS ________________________");
    }
    else {
        NSLog(@" ____________________________ FAIL ___________________________");
    }

}



// Network call to get success keyword

-(NSString *) sendAuthCode {

    // This is a network call using self.authCodeString
    // For simplicity I am hard coding the return value to success.
    
    NSString *statusString = @"success";
    
    return statusString;
    
}


// PayPalProfileSharingDelegate methods

- (void)userDidCancelPayPalProfileSharingViewController:(PayPalProfileSharingViewController *)profileSharingViewController {
    NSLog(@"PayPal Profile Sharing Authorization Canceled");
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
