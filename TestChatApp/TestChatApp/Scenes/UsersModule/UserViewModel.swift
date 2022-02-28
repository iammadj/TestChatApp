//
//  UserViewModel.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 27/02/22.
//

import Foundation

class UserViewModel {
    
    let id: String
    let nickname: String?
    let isActive: Bool
    let lastSeen: String
    var isSelected: Bool
    
    init(id: String, nickname: String?, isActive: Bool, lastSeen: String, isSelected: Bool = false) {
        self.id = id
        self.nickname = nickname
        self.isActive = isActive
        self.lastSeen = lastSeen
        self.isSelected = isSelected
    }
    
}
