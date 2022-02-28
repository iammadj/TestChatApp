//
//  ChannelViewModel.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 26/02/22.
//

import Foundation

class ChannelViewModel {
    
    var url: String
    var name: String
    var countOfParticipants: Int
            
    init(url: String, name: String, countOfParticipants: Int) {
        self.url = url
        self.name = name
        self.countOfParticipants = countOfParticipants
    }
    
}
