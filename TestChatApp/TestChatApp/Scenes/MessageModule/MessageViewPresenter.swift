//
//  MessageViewPresenter.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 26/02/22.
//

import Foundation

protocol MessageViewPresenterProtocol: BasePresenterProtocol {
    
    //MARK: - View to Presenter
    
    func fetchPrevMessages()
    func didReceive(message: String, from channelURL: String)
    func sendMessage(_ message: String)
    func routeToParticipantsView()
    
    //MARK: - Interactor to Presenter
    
    func fetchedChannelData(_ channel: SendBirdChannel)
    func fetchedMessages(_ messages: [String])
    
}

class MessageViewPresenter: BasePresenter {
    
    //MARK: - Properties
    
    private weak var view: MessageViewProtocol? {
        _view as? MessageViewProtocol
    }
    
    private var interactor: MessageViewInteractorProtocol? {
        _interactor as? MessageViewInteractorProtocol
    }
    
    private var router: MessageViewRouterProtocol? {
        _router as? MessageViewRouterProtocol
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

extension MessageViewPresenter: MessageViewPresenterProtocol {
    
    //MARK: - View to Presenter
    
    func viewDidLoad() {
        interactor?.fetchChannelData()
    }
    
    func fetchPrevMessages() {
        interactor?.fetchPrevMessages()
    }
    
    func didReceive(message: String, from channelURL: String) {
        if let currentChannelURL = interactor?.currentChannelURL {
            if currentChannelURL == channelURL {
                view?.didReceive(message: message)
            }
        }
    }
    
    func sendMessage(_ message: String) {
        interactor?.sendMessage(message)
    }
    
    func routeToParticipantsView() {
        router?.routeToParticipantsView(with: interactor?.channel)
    }
    
    //MARK: - Interactor to Presenter
    
    func fetchedChannelData(_ channel: SendBirdChannel) {
        view?.eneteredToChannel(channel.name)
    }
    
    func fetchedMessages(_ messages: [String]) {
        view?.didReceiveMessages(messages)
    }
    
}
