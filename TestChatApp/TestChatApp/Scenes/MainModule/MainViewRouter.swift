//
//  MainViewRouter.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 19/02/22.
//

import Foundation

protocol MainViewRouterProtocol: BaseRouterProtocol {
   
    func presentUsersView(_ callback: @escaping (String) -> Void)
    func routeToMessageView(channelURL: String)
    
}

class MainViewRouter: BaseRouter, MainViewRouterProtocol {
    
    //MARK: - Properties
    
    var view: MainViewProtocol? {
        _view as? MainViewProtocol
    }
    
    //MARK: - Methods
    
    func presentUsersView(_ callback: @escaping (String) -> Void) {
        let viewController = UsersViewAssembly.createModule(callback)
        present(viewController)
    }
    
    func routeToMessageView(channelURL: String) {
        let viewController = MessageViewAssembly.createModule(channelURL: channelURL)
        push(viewController)
    }
    
}
