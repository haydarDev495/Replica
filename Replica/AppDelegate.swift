//
//  AppDelegate.swift
//  Replica
//
//  Created by Haydar Bekmuradov on 12.10.23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // - window
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureWindow()
        return true
    }
}

// MARK: -
// MARK: Configure
private extension AppDelegate {
    
    func configure() {
        configureWindow()
    }
    
    func configureWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.overrideUserInterfaceStyle = .light
        let vc = UIStoryboard(name: "LoadLaunch", bundle: nil).instantiateInitialViewController() as! LoadLaunchVC
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}
