//
//  AuthViewPresenter.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 19/02/22.
//

import Foundation

protocol AuthViewPresenterProtocol: BasePresenterProtocol {
    
    //MARK: - View to Presenter
    
    func connect(withUserID userID: String)
    
    //MARK: - Interactor To Presenter
    
    func pushToMainView()
    
}

class AuthViewPresenter: BasePresenter {
    
    //MARK: - Properties
    
    private weak var view: AuthViewProtocol? {
        _view as? AuthViewProtocol
    }
    
    private var interactor: AuthViewInteractorProtocol? {
        _interactor as? AuthViewInteractorProtocol
    }
    
    private var router: AuthViewRouterProtocol? {
        _router as? AuthViewRouterProtocol
    }
    
    //MARK: - Init
    
    required init(view: BaseViewProtocol, interactor: BaseInteractorProtocol, router: BaseRouterProtocol) {
        super.init()
        
        self._view = view
        self._interactor = interactor
        self._router = router
    }
}

//MARK: - Presenter Protocol Implementation

extension AuthViewPresenter: AuthViewPresenterProtocol {
    
    func connect(withUserID userID: String) {
        interactor?.connectToUser(withUserID: userID)
    }
    
    func pushToMainView() {
        router?.pushToNextView()
    }
    
}
