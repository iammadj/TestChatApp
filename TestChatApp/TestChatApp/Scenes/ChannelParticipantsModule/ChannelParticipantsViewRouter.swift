//
//  ChannelParticipantsViewRouter.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 28/02/22.
//

import Foundation

protocol ChannelParticipantsViewRouterProtocol: BaseRouterProtocol {
   
}

class ChannelParticipantsViewRouter: BaseRouter,  ChannelParticipantsViewRouterProtocol {
    
    //MARK: - Properties
    
    var view: ChannelParticipantsViewProtocol? {
        _view as? ChannelParticipantsViewProtocol
    }
    
    //MARK: - Methods
    
    
    
}
