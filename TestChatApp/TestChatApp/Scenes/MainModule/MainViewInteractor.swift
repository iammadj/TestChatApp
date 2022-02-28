//
//  MainViewInteractor.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 19/02/22.
//

import Foundation

protocol MainViewInteractorProtocol: BaseInteractorProtocol {
    
    func fetchAllChannels()
    func createNewChannel(url: String?, name: String, users: [String])
   
}

class MainViewInteractor: BaseInteractor,  MainViewInteractorProtocol {

    //MARK: - Properties
    
    var presenter: MainViewPresenterProtocol? {
        _presenter as? MainViewPresenterProtocol
    }
    
    //MARK: - Methods
    
    func fetchAllChannels() {
        SendBirdManager.fetchAllChannels { [weak self] result in
            switch result {
            case .success(let channels):
                let mappedChannels = channels.map {
                    ChannelViewModel(url: $0.channelUrl, name: $0.name, countOfParticipants: $0.participantCount)
                }
                self?.presenter?.fetchedChannels(mappedChannels)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func createNewChannel(url: String?, name: String, users: [String]) {
        let params = ChannelViewModel(url: url.orEmpty, name: name, countOfParticipants: 0)
        SendBirdManager.createChannel(with: params, userIDs: users) { [weak self] result in
            switch result {
            case .success(let channel):
                let channel = ChannelViewModel(url: channel.channelUrl, name: channel.name, countOfParticipants: channel.participantCount)
                self?.presenter?.newChannelCreated(channel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
