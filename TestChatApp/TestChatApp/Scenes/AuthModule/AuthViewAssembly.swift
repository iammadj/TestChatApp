//
//  AuthViewAssembly.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 19/02/22.
//

import UIKit.UIViewController

enum AuthViewAssembly {
    
    static func createModule() -> UIViewController {
        let view = AuthViewController()
        let interactor = AuthViewInteractor()
        let router = AuthViewRouter()
        let presenter = AuthViewPresenter(view: view, interactor: interactor, router: router)
        
        view._presenter = presenter
        interactor._presenter = presenter
        router._view = view
        
        return view
    }
    
}
