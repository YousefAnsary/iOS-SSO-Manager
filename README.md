# SSOManager

*** Swift Package that helps you implement Facebook, Google and Apple social login in a simple way, It is developed originally by Ahmad Mahmoud then maintained and refactored into a package by me

### Contents
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Examples](#examples)

----

### Features

- [x] Embeds and Based Originally on Google & Facebook Packages and ASAutorization (no need to add them exteranlly)
- [x] Well designed in an abstracted way so you will interact with only one interface for all SSOs
- [x] Does not read IDs from Info.plist, you will pass the IDs to SSOManager yourself
- [ ] Scene Delegate URL Callbacks is not supported yet

----

### Requirements
- Swift 4.2+
- Xcode 11+

----

### Installation

**Swift Package Manager**

```
.package(url: "https://github.com/YousefAnsary/iOS-SSO-Manager.git", from: "1.0")
```

----

### Usage

1- If you don't have Facebook client token, Google clientID or did not enable Apple Login head to their portals to do so, <br/>
[FB](https://developers.facebook.com/docs/facebook-login/ios/) <br/>
[Google](https://developers.google.com/identity/sign-in/ios/start-integrating) <br/>
[Apple](https://medium.com/@priya_talreja/sign-in-with-apple-using-swift-5cd8695a46b6) <br/>

2- Initialize SSOManager passing the required methods with required IDs in `AppDelegate.application(didFinishLaunchingWithOptions:)`
```
let ssoMethods = [FacebookSignIn(appId: "", facebookAppId: "", facebookClientToken: ""),
                  GoogleSignIn(clientID: ""),
                  AppleSignIn()]
SSOManager.initialize(withMethods: ssoMethods)
```
<br/>

3- implement required callbacks in your AppDelegate and let SSOManager gets notified like so
```
func application(_ application: UIApplication,
                 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
                 
     let ssoMethods = [FacebookSignIn(appId: "", facebookAppId: "", facebookClientToken: ""),
                       GoogleSignIn(clientID: ""),
                       AppleSignIn()]
     SSOManager.initialize(withMethods: ssoMethods)
     SSOManager.shared.application?(application, didFinishLaunchingWithOptions: launchOptions)
     return true
}

func application(_ application: UIApplication,
                 open url: URL,
                 sourceApplication: String?,
                 annotation: Any) -> Bool {
     SSOManager.shared.application?(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
}

func application(_ app: UIApplication,
                 open url: URL,
                 options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
     SSOManager.shared.application?(app, open: url, options: options)
}
```

