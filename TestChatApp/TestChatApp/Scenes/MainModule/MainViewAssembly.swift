//
//  MainViewAssembly.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 19/02/22.
//

import UIKit.UIViewController

enum MainViewAssembly {
    
    static func createModule() -> UIViewController {
        let view = MainViewController()
        let interactor = MainViewInteractor()
        let router = MainViewRouter()
        let presenter = MainViewPresenter(view: view, interactor: interactor, router: router)
        
        view._presenter = presenter
        interactor._presenter = presenter
        router._view = view
        
        return view
    }
    
}
