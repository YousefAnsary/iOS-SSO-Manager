# SSOManager

***Swift Package that helps you implement Facebook, Google and Apple social login in a simple way, It is developed originally by [Ahmad Mahmoud](https://linkedin.com/in/amssm) then maintained and refactored into a package by me***

### Contents
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)

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

2- Set URL Types & URL Queried URL Schemes in your Info.plist like following replacing with your IDs
```
<key>CFBundleURLTypes</key>
	<array>
		<dict>
			<key>CFBundleTypeRole</key>
			<string>Editor</string>
			<key>CFBundleURLName</key>
			<string>FBAuth</string>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>fb[YOUR-FB-ID]</string>
			</array>
		</dict>
		<dict>
			<key>CFBundleTypeRole</key>
			<string>Editor</string>
			<key>CFBundleURLName</key>
			<string>GoogleAuth</string>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>[YOUR-REVRSED-GOOGLE-CLIENT-ID]</string>
			</array>
		</dict>
	</array>
	<key>LSApplicationQueriesSchemes</key>
	<array>
		<string>fb</string>
		<string>fbapi</string>
		<string>fbauth2</string>
	</array>
```
<br/>

3- You must Initialize SSOManager passing the required methods with required IDs in `AppDelegate.application(didFinishLaunchingWithOptions:)`
```
let ssoMethods: [SSOProtocol] = [FacebookSignIn(bundleID: "", facebookAppId: "", facebookClientToken: ""),
                                 GoogleSignIn(clientID: ""), // Not Reversed ID
                                 AppleSignIn()]
SSOManager.initialize(withMethods: ssoMethods)
```
<br/>

4- implement required callbacks in your AppDelegate and let SSOManager gets notified:
```
func application(_ application: UIApplication,
                 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
     let ssoMethods: [SSOProtocol] = [FacebookSignIn(appId: "", facebookAppId: "", facebookClientToken: ""),
                                      GoogleSignIn(clientID: ""), // Not Reversed ID
                                      AppleSignIn()]
     SSOManager.initialize(withMethods: ssoMethods)
     _ = SSOManager.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
     return true
}

func application(_ application: UIApplication,
                 open url: URL,
                 sourceApplication: String?,
                 annotation: Any) -> Bool {
     SSOManager.shared.application(application,
                                   open: url,
                                   sourceApplication: sourceApplication,
                                   annotation: annotation) ?? false
}

func application(_ app: UIApplication,
                 open url: URL,
                 options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
     SSOManager.shared.application(app, open: url, options: options) ?? false
}
```
5- Then you can use it directly as an action for your button or so:
```
SSOManager.shared.signIn(strategy: .facebook, // or .google or .apple
                         successAction: { ssoUserData in 
                            // Do your action here like calling your BE to provide the token or so 
                         }, errorAction: { ssoManagerError in 
                            // Handle the error
                         })

```
also it has another version that is available only on iOS 13 and above 
```
signIn(strategy: SSOStrategy) async -> Result<SSOUser, SSOManagerError>
```
----
```
public struct SSOUser {
    public let id: String?
    public let name: String?
    public let firstName: String?
    public let familyName: String?
    public let email: String?
    public let ssoToken: String?
}

public enum SSOManagerError: LocalizedError {
    case strategyNotFound(_ strategy: SSOStrategy)
    case appleSignInNotSupported
    case appleSignInError(Error)
    case appleConformanceNeeded(vc: UIViewController)
    case userError
    case unableToFetchTopVC
    case unknownError(Error?)
}
```
----
6- to sign out use
```
SSOManager.shared.signOut(from: .facebook // or .google or .apple )
```
Or Sign out from all by invoking
```
SSOManager.shared.signOut()
```
**For Detailed Sample head to: [Sample](/Sample)**


