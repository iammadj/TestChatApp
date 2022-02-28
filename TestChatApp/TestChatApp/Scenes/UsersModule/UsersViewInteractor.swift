//
//  UsersViewInteractor.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 27/02/22.
//

import Foundation

protocol UsersViewInteractorProtocol: BaseInteractorProtocol {
        
    func fetchAllUsers()
   
}

class UsersViewInteractor: BaseInteractor, UsersViewInteractorProtocol {

    //MARK: - Properties
    
    var presenter: UsersViewPresenterProtocol? {
        _presenter as? UsersViewPresenterProtocol
    }
    
    //MARK: - Methods
    
    func fetchAllUsers() {
        SendBirdManager.getUsers { [weak self] result in
            switch result {
            case .success(let users):
                self?.presenter?.fetchedUsers(users)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
