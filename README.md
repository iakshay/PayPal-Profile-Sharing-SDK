#Profile Sharing SDK

###Project
Use a custom SDK to open native PayPal login screen with the help of Profile Sharing use case by [PayPal iOS SDK](https://github.com/paypal/PayPal-iOS-SDK). After successful login, the goal is to transition to `NextViewController`. 

###Instructions for the reference implementation -

1) Open `TestingLaunchPayPalSDK.xcodeproj` in [Xcode Version 6.0.1](https://itunes.apple.com/us/app/xcode/id497799835?ls=1&mt=12) or later. 

2) Build the project Command (⌘) + R

3) Login with your [PayPal Sandbox credentials](https://developer.paypal.com/docs/classic/lifecycle/sb_create-accounts/) or log in with -

* Username: **test.sandbox@gmail.com**

* Password: **stackoverflow**

4) After entering credentials, intercept 'success' keyword and transition to `NextViewController` of the SampleApp.


### StackOverFlow Question - 

http://stackoverflow.com/questions/26165235/update-completion-handler-outside-declared-method


###Instructions for creating a universal binary

1) Open LaunchPayPalSDK.xcodeproj in Xcode 6.0.1 or later. Enter your Sandbox Client ID in `PayPalViewController.m`

2) Build the project Command (⌘) + R

3) Under Products, right click on `libLaunchPayPalSDK.a`

4) Link the `libLaunchPayPalSDK.a` and `PayPalViewController.h` to your reference implementation.

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




