//
//  ChannelParticipantsViewPresenter.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 28/02/22.
//

import Foundation

protocol ChannelParticipantsViewPresenterProtocol: BasePresenterProtocol {
    
    func fetchedUsers(_ users: [UserViewModel])
    
}

class ChannelParticipantsViewPresenter: BasePresenter {
    
    //MARK: - Properties
    
    private weak var view: ChannelParticipantsViewProtocol? {
        _view as? ChannelParticipantsViewProtocol
    }
    
    private var interactor: ChannelParticipantsViewInteractorProtocol? {
        _interactor as? ChannelParticipantsViewInteractorProtocol
    }
    
    private var router: ChannelParticipantsViewRouterProtocol? {
        _router as? ChannelParticipantsViewRouterProtocol
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

extension ChannelParticipantsViewPresenter: ChannelParticipantsViewPresenterProtocol {
    
    func viewDidLoad() {
        interactor?.fetchParticipants()
    }
    
    func fetchedUsers(_ users: [UserViewModel]) {
        view?.fetchedParticipants(users)
    }
    
}
