//
//  MainViewPresenter.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 19/02/22.
//

import Foundation

protocol MainViewPresenterProtocol: BasePresenterProtocol {
    
    //MARK: - View to Presenter
    
    func createNewChannel(url: String?, name: String)
    func routeToMessageView(with channelURL: String)
    
    //MARK: - Interactor to Presenter
    
    func fetchedChannels(_ channels: [ChannelViewModel])
    func newChannelCreated(_ channel: ChannelViewModel)
}

class MainViewPresenter: BasePresenter {
    
    //MARK: - Properties
    
    private weak var view: MainViewProtocol? {
        _view as? MainViewProtocol
    }
    
    private var interactor: MainViewInteractorProtocol? {
        _interactor as? MainViewInteractorProtocol
    }
    
    private var router: MainViewRouterProtocol? {
        _router as? MainViewRouterProtocol
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

extension MainViewPresenter: MainViewPresenterProtocol {
    
    //MARK: - View to Presenter
    
    func viewDidLoad() {
        interactor?.fetchAllChannels()
    }
    
    func createNewChannel(url: String?, name: String) {
        router?.presentUsersView({ [weak self] userID in
            self?.interactor?.createNewChannel(url: url, name: name, users: [userID])
        })
    }
    
    func routeToMessageView(with channelURL: String) {
        router?.routeToMessageView(channelURL: channelURL)
    }
    
    //MARK: - Interactor to Presenter
    
    func fetchedChannels(_ channels: [ChannelViewModel]) {
        view?.fetchedChannels(channels)
    }
    
    func newChannelCreated(_ channel: ChannelViewModel) {
        view?.newChannelCreated(channel)
    }
    
}
