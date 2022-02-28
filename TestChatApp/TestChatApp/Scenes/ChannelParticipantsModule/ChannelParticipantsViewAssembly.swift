//
//  ChannelParticipantsViewAssembly.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 28/02/22.
//

import UIKit.UIViewController

enum ChannelParticipantsViewAssembly {
    
    static func createModule(channel: SendBirdChannel?) -> UIViewController {
        let view = ChannelParticipantsViewController()
        let interactor = ChannelParticipantsViewInteractor(channel: channel)
        let router = ChannelParticipantsViewRouter()
        let presenter = ChannelParticipantsViewPresenter(view: view, interactor: interactor, router: router)
        
        view._presenter = presenter
        interactor._presenter = presenter
        router._view = view
        
        return view
    }
    
}
