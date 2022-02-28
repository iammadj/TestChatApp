//
//  MessageViewRouter.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 26/02/22.
//

import Foundation

protocol MessageViewRouterProtocol: BaseRouterProtocol {
    
    func routeToParticipantsView(with channel: SendBirdChannel?)
   
}

class MessageViewRouter: BaseRouter,  MessageViewRouterProtocol {
    
    //MARK: - Properties
    
    var view: MessageViewProtocol? {
        _view as? MessageViewProtocol
    }
    
    //MARK: - Methods
    
    func routeToParticipantsView(with channel: SendBirdChannel?) {
        let viewController = ChannelParticipantsViewAssembly.createModule(channel: channel)
        push(viewController)
    }
    
}
