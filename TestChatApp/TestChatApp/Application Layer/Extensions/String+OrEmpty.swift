//
//  String+OrEmpty.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 23/02/22.
//

import Foundation

extension Optional where Wrapped == String {
    
    var orEmpty: String {
        switch self {
        case .none:
            return ""
        case .some(let data):
            return data
        }
    }
    
}
