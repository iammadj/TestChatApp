//
//  AppStarter.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 23/02/22.
//

import UIKit

class AppStarter {
    
    enum StartMode {
        case auth, main
    }
    
    //MARK: - Properties
    private var window: UIWindow?
    
    //MARK: - Initialization
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    //MARK: - Methods
    
    func startRouting() {
        let keychain: KeyValueStorage = KeychainStorageImp()
        
        /// Initialize SendBird SDK
        SendBirdManager.initializeWithAppID()
        
        /// Connect User And Start Routing
        
        if let userID = keychain.userID {
            SendBirdManager.connectWith(userID: userID) { _ in
                keychain.set(string: userID, for: KeychainKey.userID.rawValue)
                self.startFrom(.main)
            }
        } else {
            startFrom(.auth)
        }
    }
    
    private func startFrom(_ mode: StartMode) {
        let rootViewController = createRootViewController(stating: mode)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
    private func createRootViewController(stating mode: StartMode) -> UINavigationController {
        var rootViewController: UIViewController!
        
        switch mode {
        case .auth: rootViewController = AuthViewAssembly.createModule()
        case .main: rootViewController = MainViewAssembly.createModule()
        }
                
        return BaseNavigationController(rootViewController: rootViewController)
    }
    
}
