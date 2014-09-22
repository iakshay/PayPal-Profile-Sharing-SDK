#Profile Sharing SDK

###Project
Use a custom SDK to open native PayPal login screen with the help of Profile Sharing use case by [PayPal iOS SDK](https://github.com/paypal/PayPal-iOS-SDK).

###Instructions for the reference implementation -

1) Open `TestingLaunchPayPalSDK.xcodeproj` in [Xcode Version 5.1.1](https://developer.apple.com/downloads/index.action#) or later. 

2) Build the project Command (⌘) + R

3) Login with your [PayPal Sandbox credentials](https://developer.paypal.com/docs/classic/lifecycle/sb_create-accounts/).

4) The PayPal iOS SDK provides an API to obtain user consent for profile sharing. The SDK is integrated into this sample app and is using it to authenticate the user and obtain the user's consent. The SDK handles authentication and authorization with the PayPal authentication server, and returns an OAuth2 authorization code as the output.


###Response

This authorization response is a NSDictionary object which can be seen in a debug window. Example:

    {
    client =     {
        environment = sandbox;
        "paypal_sdk_version" = "2.3.2";
        platform = iOS;
        "product_name" = "PayPal iOS SDK";
    };
    response =     {
        code = "EJhi9jOPswug9TDOv93qg4Y28xIlqPDpAoqd7biDLpeGCPvORHjP1Fh4CbFPgKMGCHejdDwe9w1uDWnjPCp1lkaFBjVmjvjpFtnr6z1YeBbmfZYqa9faQT_71dmgZhMIFVkbi4yO7hk0LBHXt_wtdsw";
    };
    "response_type" = "authorization_code";
    }

###Instructions for creating a universal binary

1) Open LaunchPayPalSDK.xcodeproj in Xcode 5.1 or later. Enter your Sandbox Client ID in `PayPalViewController.m`

2) Build the project Command (⌘) + R

3) Under Products, right click on `libLaunchPayPalSDK.a`

4) Link the `libLaunchPayPalSDK.a` and `PayPalViewController.h` to your reference implementation.


