//
//  ChannelParticipantsViewInteractor.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 28/02/22.
//

import Foundation

protocol ChannelParticipantsViewInteractorProtocol: BaseInteractorProtocol {
    
    func fetchParticipants()
   
}

class ChannelParticipantsViewInteractor: BaseInteractor,  ChannelParticipantsViewInteractorProtocol {

    //MARK: - Properties
    
    var presenter: ChannelParticipantsViewPresenterProtocol? {
        _presenter as? ChannelParticipantsViewPresenterProtocol
    }
    
    private let channel: SendBirdChannel?
    
    init(channel: SendBirdChannel?) {
        self.channel = channel
    }
    
    //MARK: - Methods
    
    func fetchParticipants() {
        SendBirdManager.getAllParticipants(for: channel) { [weak self] result in
            switch result {
            case .success(let users):
                self?.presenter?.fetchedUsers(users)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
