//
//  MessagedError.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 27/02/22.
//

import Foundation

struct MessagedError: LocalizedError {
    let message: String
    var errorDescription: String? { message }
}
