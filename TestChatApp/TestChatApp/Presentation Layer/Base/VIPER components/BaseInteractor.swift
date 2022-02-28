//
//  BaseInteractor.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 19/02/22.
//

import Foundation

protocol BaseInteractorProtocol: AnyObject {}

class BaseInteractor {
    
    var _presenter: BasePresenterProtocol?
    
}
