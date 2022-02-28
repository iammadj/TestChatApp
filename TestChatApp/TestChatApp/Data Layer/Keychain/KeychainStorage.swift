//
//  KeychainStorage.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 23/02/22.
//

import Foundation
import KeychainAccess

protocol KeyValueStorage {
    
    var userID: String? { get }
    
    func set(string: String, for key: String)
    func set(data: Data, for key: String)
    func string(for key: String) -> String?
    func data(for key: String) -> Data?
    func remove(for key: String)
    func set(dictionary: [String: Any], for key: String)
    func set(bool: Bool, for key: String)
    func bool(for key: String) -> Bool
    func set(double: Double, for key: String)
    func double(for key: String) -> Double
    
}

//MARK: - Implementation

class KeychainStorageImp: KeyValueStorage {
    
    lazy var keychain: Keychain = {
        if let group = accessGroup {
            return Keychain(service: service, accessGroup: group)
        } else {
            return Keychain(service: service)
        }
    }()
    
    let service: String
    let accessGroup: String?
    
    init(service: String = Constants.keychainService, accessGroup: String? = nil) {
        self.service = service
        self.accessGroup = accessGroup
    }
    
    //MARK: - Properties
    
    var userID: String? {
        try? keychain.getString(KeychainKey.userID.rawValue)
    }
    
    //MARK: - Methods
    
    func set(string: String, for key: String) {
        keychain[string: key] = string
    }
    
    func set(data: Data, for key: String) {
        keychain[data: key] = data
    }
    
    func string(for key: String) -> String? {
        try? keychain.getString(key)
    }
    
    func data(for key: String) -> Data? {
        try? keychain.getData(key)
    }
    
    func remove(for key: String) {
        keychain[key] = nil
    }
    
    func set(dictionary: [String : Any], for key: String) {
        fatalError("Unsupported yet")
    }
    
    func set(bool: Bool, for key: String) {
        fatalError("Unsupported yet")
    }
    
    func bool(for key: String) -> Bool {
        fatalError("Unsupported yet")
    }
    
    func set(double: Double, for key: String) {
        fatalError("Unsupported yet")
    }
    
    func double(for key: String) -> Double {
        fatalError("Unsupported yet")
    }
    
}

enum KeychainKey: String, CaseIterable {
    case apiKey = "api.key"
    case userID = "user.id"
}
