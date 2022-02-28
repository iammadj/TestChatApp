//
//  AuthViewRouter.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 19/02/22.
//

import Foundation
import UIKit

protocol AuthViewRouterProtocol: BaseRouterProtocol {
    
    func pushToNextView()
   
}

class AuthViewRouter: BaseRouter,  AuthViewRouterProtocol {
    
    //MARK: - Properties
    
    var view: AuthViewProtocol? {
        _view as? AuthViewProtocol
    }
    
    //MARK: - Methods
    
    func pushToNextView() {
        let mainViewController = MainViewAssembly.createModule()
        let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        window?.rootViewController = BaseNavigationController(rootViewController: mainViewController)
    }
    
}
