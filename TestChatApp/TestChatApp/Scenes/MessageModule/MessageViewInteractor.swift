//
//  MessageViewInteractor.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 26/02/22.
//

import Foundation

protocol MessageViewInteractorProtocol: BaseInteractorProtocol {
    
    var currentChannelURL: String { get }
    var channel: SendBirdChannel? { get set }
    
    func fetchChannelData()
    func fetchPrevMessages()
    func sendMessage(_ message: String)
    
}

class MessageViewInteractor: BaseInteractor,  MessageViewInteractorProtocol {

    //MARK: - Properties
    
    var presenter: MessageViewPresenterProtocol? {
        _presenter as? MessageViewPresenterProtocol
    }
    
    var currentChannelURL: String { channelURL }
    var channel: SendBirdChannel?
    
    private let channelURL: String
    
    
    init(channelURL: String) {
        self.channelURL = channelURL
    }
    
    //MARK: - Methods
    
    func fetchChannelData() {
        SendBirdManager.getChannel(with: channelURL) { [weak self] result in
            switch result {
            case .success(let channel):
                self?.channel = channel
                print(channel)
                self?.presenter?.fetchedChannelData(channel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchPrevMessages() {
        SendBirdManager.loadMessages(for: channel) { [weak self] result in
            switch result {
            case .success(let messages):
                self?.presenter?.fetchedMessages(messages)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func sendMessage(_ message: String) {
        guard let channel = channel else { return }
        SendBirdManager.sendMessage(from: channel, message: message) { [weak self] result in
            switch result {
            case .success(let message):
                self?.presenter?.didReceive(message: message, from: channel.channelUrl)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
