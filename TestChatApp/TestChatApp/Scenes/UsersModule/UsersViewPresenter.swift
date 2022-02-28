//
//  UsersViewPresenter.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 27/02/22.
//

import Foundation

protocol UsersViewPresenterProtocol: BasePresenterProtocol {
    
    //MARK: - View to Presenter
    
    func didSelect(userID: String)
        
    //MARK: - Interactor to Presenter
    
    func fetchedUsers(_ users: [UserViewModel])
    
}

class UsersViewPresenter: BasePresenter {
    
    //MARK: - Properties
    
    private weak var view: UsersViewProtocol? {
        _view as? UsersViewProtocol
    }
    
    private var interactor: UsersViewInteractorProtocol? {
        _interactor as? UsersViewInteractorProtocol
    }
    
    private var router: UsersViewRouterProtocol? {
        _router as? UsersViewRouterProtocol
    }
    
    var didSelectUser: ((String) -> Void)?
    
    //MARK: - Init
    
    required init(view: BaseViewProtocol, interactor: BaseInteractorProtocol, router: BaseRouterProtocol) {
        super.init()
        
        self._view = view
        self._interactor = interactor
        self._router = router
    }
}

//MARK: - Presenter Protocol Implementation

extension UsersViewPresenter: UsersViewPresenterProtocol {
    
    //MARK: - View to Presenter
    
    func viewDidLoad() {
        interactor?.fetchAllUsers()
    }
    
    func didSelect(userID: String) {
        didSelectUser?(userID)
        router?.close()
    }
    
    //MARK: - Interactor to Presenter
    
    func fetchedUsers(_ users: [UserViewModel]) {
        view?.fetchedUsers(users)
    }
    
}
