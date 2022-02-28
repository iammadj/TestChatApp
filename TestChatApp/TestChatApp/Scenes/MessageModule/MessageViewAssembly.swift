//
//  MessageViewAssembly.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 26/02/22.
//

import UIKit.UIViewController

enum MessageViewAssembly {
    
    static func createModule(channelURL: String) -> UIViewController {
        let view = MessageViewController()
        let interactor = MessageViewInteractor(channelURL: channelURL)
        let router = MessageViewRouter()
        let presenter = MessageViewPresenter(view: view, interactor: interactor, router: router)
        
        view._presenter = presenter
        interactor._presenter = presenter
        router._view = view
        
        return view
    }
    
}
