//
//  UsersViewAssembly.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 27/02/22.
//

import UIKit.UIViewController

enum UsersViewAssembly {
    
    static func createModule(_ callback: @escaping (String) -> Void) -> UIViewController {
        let view = UsersViewController()
        let interactor = UsersViewInteractor()
        let router = UsersViewRouter()
        let presenter = UsersViewPresenter(view: view, interactor: interactor, router: router)
        presenter.didSelectUser = callback
        
        view._presenter = presenter
        interactor._presenter = presenter
        router._view = view
        
        return view
    }
    
}
