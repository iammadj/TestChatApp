//
//  AuthViewInteractor.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 19/02/22.
//

import Foundation

protocol AuthViewInteractorProtocol: BaseInteractorProtocol {

    func connectToUser(withUserID: String)
    
}

class AuthViewInteractor: BaseInteractor,  AuthViewInteractorProtocol {

    //MARK: - Properties
    
    var presenter: AuthViewPresenterProtocol? {
        _presenter as? AuthViewPresenterProtocol
    }
    
    private let keychain: KeyValueStorage = KeychainStorageImp()
    
    //MARK: - Methods
    
    func connectToUser(withUserID userID: String) {
        SendBirdManager.connectWith(userID: userID) { [weak self] userID in
            self?.keychain.set(string: userID, for: KeychainKey.userID.rawValue)
            self?.presenter?.pushToMainView()
        }
    }
    
}
