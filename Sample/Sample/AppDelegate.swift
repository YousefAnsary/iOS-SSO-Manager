//
//  AppDelegate.swift
//  Sample
//
//  Created by Youssef El-Ansary on 26/10/2022.
//

import UIKit
import SwiftUI
import SSOManager

@main
class AppDelegate: NSObject, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        let fb = FacebookSignIn(appId: Bundle.main.bundleIdentifier!,
                                facebookAppId: "1238865068099456",
                                facebookClientToken: "1c23c0537e3065c77b2606640456f1ae")
        let google = GoogleSignIn(clientID: "123488644456-843fumi3eub8el53hhj2rc6edqn1j68p.apps.googleusercontent.com")
        let ssoMethods: [SSOProtocol] = [fb, google, AppleSignIn()]
        SSOManager.initialize(withMethods: ssoMethods)
        _ = SSOManager.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UIHostingController(rootView: ContentView())
        self.window?.makeKeyAndVisible()
        return true
    }

    func application(_ application: UIApplication,
                     open url: URL,
                     sourceApplication: String?,
                     annotation: Any) -> Bool {
        SSOManager.shared.application(application,
                                      open: url,
                                      sourceApplication: sourceApplication,
                                      annotation: annotation)
    }

    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
         SSOManager.shared.application(app, open: url, options: options)
    }
}
