//
//  LoadLaunchVC.swift
//  Replica
//
//  Created by Haydar Bekmuradov on 12.10.23.
//

import UIKit

class LoadLaunchVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

// MARK: -
// MARK: - Configure
private extension LoadLaunchVC {
    
    func configure() {
        configureMainVC()
    }
    
    func configureMainVC() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let vc = MainVC()
            let nc = UINavigationController(rootViewController: vc)
            appDelegate.window?.rootViewController = nc
            UIView.transition(with: appDelegate.window ?? UIWindow(), duration: 0.5, options: .transitionCrossDissolve) {
                appDelegate.window?.makeKeyAndVisible()
            }
        }
    }
}
