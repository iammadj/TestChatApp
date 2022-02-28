//
//  UsersViewRouter.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 27/02/22.
//

import Foundation

protocol UsersViewRouterProtocol: BaseRouterProtocol {
   
    func close()
    
}

class UsersViewRouter: BaseRouter,  UsersViewRouterProtocol {
    
    //MARK: - Properties
    
    var view: UsersViewProtocol? {
        _view as? UsersViewProtocol
    }
    
    //MARK: - Methods
    
    func close() {
        dismiss()
    }
    
}
