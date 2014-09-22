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

@interface PayPalViewController () <PayPalProfileSharingDelegate> {
    dispatch_once_t once;
}


@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;
@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, strong, readwrite) NSString *resultText;
@property(nonatomic, strong, readwrite) NSString *authCodeString;
@property(nonatomic, strong, readwrite) NSString *code;

@end

@implementation PayPalViewController

- (id) init {
    static NSString const *kSandboxEnvironment = @"AWUrShDrIsirRkPOsFgGCYEX04f9DIsfmJryD0EglO-KlfA3Nkwg-CU4cmAr";
    [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentSandbox : kSandboxEnvironment}];
    
    [PayPalMobile preconnectWithEnvironment:PayPalEnvironmentSandbox];
    NSLog(@"Preconnected to PayPal. Success.");

    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"viewDidLoad");
    [self getUserAuthorizationForProfileSharing];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"viewAppear");
}

- (void)viewDidAppear:(BOOL)animated {
    dispatch_once(&once, ^{
        
        [self getUserAuthorizationForProfileSharing];
    });
    NSLog(@"ViewDidAppear");
}


#pragma mark - Authorize Profile Sharing

- (void)getUserAuthorizationForProfileSharing {
    
    self.payPalConfig = [[PayPalConfiguration alloc] init];
    self.payPalConfig.acceptCreditCards = YES;
    self.payPalConfig.languageOrLocale = @"en";
    self.payPalConfig.merchantName = @"Anonymous Merchant";
    self.payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
    self.payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
    self.payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    self.payPalConfig.payPalShippingAddressOption = PayPalShippingAddressOptionPayPal;

    NSSet *scopeValues = [NSSet setWithArray:@[kPayPalOAuth2ScopeEmail, kPayPalOAuth2ScopeAddress, kPayPalOAuth2ScopeOpenId, kPayPalOAuth2ScopePhone]];
    
    PayPalProfileSharingViewController *profileSharingPaymentViewController = [[PayPalProfileSharingViewController alloc] initWithScopeValues:scopeValues configuration:self.payPalConfig delegate:self];
    
    [self presentViewController:profileSharingPaymentViewController animated:YES completion:nil];
}


#pragma mark PayPalProfileSharingDelegate methods

- (void)payPalProfileSharingViewController:(PayPalProfileSharingViewController *)profileSharingViewController 
             userDidLogInWithAuthorization:(NSDictionary *)profileSharingAuthorization {
    
    NSLog(@"PayPal Profile Sharing Authorization Success!");
    self.resultText = [profileSharingAuthorization description];
    
    [self sendProfileSharingAuthorizationToServer:profileSharingAuthorization];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)userDidCancelPayPalProfileSharingViewController:(PayPalProfileSharingViewController *)profileSharingViewController {
    NSLog(@"PayPal Profile Sharing Authorization Canceled");
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)sendProfileSharingAuthorizationToServer:(NSDictionary *)authorization {

    NSLog(@"Here is your authorization  %@:", authorization);
    NSDictionary *getAuthCodeDictionary = [authorization valueForKeyPath:@"response.code"];
    self.authCodeString = [NSString stringWithFormat:@"%@", getAuthCodeDictionary];
}


@end
