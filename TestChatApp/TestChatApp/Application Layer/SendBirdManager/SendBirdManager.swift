//
//  SendBirdManager.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 23/02/22.
//

import Foundation
import SendBirdSDK

typealias SendBirdChannel = SBDOpenChannel
typealias SendBirdChannelDelegate = SBDChannelDelegate

class SendBirdManager: NSObject {
    
    static var didHandleMessage: ((String) -> Void)?
    
    //MARK: - Initialize
        
    class func initializeWithAppID() {
        SBDMain.initWithApplicationId(Constants.sendBirdAppId, useCaching: true) {
            
        } completionHandler: { error in
            if let error = error {
                print(error.localizedDescription + " in " + #function)
            }
        }
    }
    
    //MARK: - Connectivity
    
    class func connectWith(userID: String, completion: @escaping (String) -> Void) {
        SBDMain.connect(withUserId: userID) { user, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let user = user else {
                print("There is no user!" + " in " + #function)
                return
            }
            
            completion(user.userId)
        }
    }
    
    class func disconnect() {
        SBDMain.disconnect(completionHandler: nil)
    }
    
    //MARK: - Listeners
    
    class func add(_ listener: SendBirdChannelDelegate, identifier: String) {
        SBDMain.add(listener as SBDChannelDelegate, identifier: identifier)
    }
    
    class func removeListener(forIdentifier id: String) {
        SBDMain.removeChannelDelegate(forIdentifier: id)
    }
    
    class func getUsers(_ completion: @escaping (Result<[UserViewModel], Error>) -> Void) {
        let usersQuery = SBDMain.createApplicationUserListQuery()
        
        usersQuery?.loadNextPage(completionHandler: { users, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let users = users else {
                completion(.failure(MessagedError(message: "Could not get Users in " + #function)))
                return
            }
            
            let mappedUsers = users.map {
                UserViewModel(id: $0.userId, nickname: $0.nickname, isActive: $0.isActive, lastSeen: String($0.lastSeenAt))
            }
            
            completion(.success(mappedUsers))
        })
    }
    
    //MARK: - Channels
    
    class func fetchAllChannels(_ completion: @escaping (Result<[SBDOpenChannel], Error>) -> Void) {
        let listQuery = SBDOpenChannel.createOpenChannelListQuery()
        listQuery?.loadNextPage(completionHandler: { channels, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let channels = channels {
                completion(.success(channels))
            }
        })
    }
    
    class func createChannel(with channel: ChannelViewModel, userIDs: [String], completion: @escaping (Result<SBDOpenChannel, Error>) -> Void) {
        let keychain: KeyValueStorage = KeychainStorageImp()
        let params = SBDOpenChannelParams()
        
        params.name = channel.name
        params.operatorUserIds = userIDs
        
        if !channel.url.isEmpty {
            params.channelUrl = channel.url
        }
        
        if let userID = keychain.userID {
            params.operatorUserIds?.append(userID)
        }
        
        SBDOpenChannel.createChannel(with: params) { channel, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let channel = channel {
                completion(.success(channel))
            }
        }
    }
    
    class func getChannel(with url: String, completion: @escaping (Result<SBDOpenChannel, Error>) -> Void) {
        SBDOpenChannel.getWithUrl(url) { channel, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let channel = channel else {
                completion(.failure(MessagedError(message: "Something went wrong on fetching Channel in " + #function)))
                return
            }
            
            channel.enter(completionHandler: { error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                completion(.success(channel))
            })
            
            
        }
    }
    
    class func getAllParticipants(for channel: SendBirdChannel?, _ completion: @escaping (Result<[UserViewModel], Error>) -> Void) {
        let participants = channel?.createParticipantListQuery()
        
        participants?.loadNextPage(completionHandler: { users, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let users = users else {
                completion(.failure(MessagedError(message: "Could not get Participants in " + #function)))
                return
            }
            
            let mappedUsers = users.map {
                UserViewModel(id: $0.userId, nickname: $0.nickname, isActive: $0.isActive, lastSeen: String($0.lastSeenAt))
            }
            
            completion(.success(mappedUsers))
        })
    }
    
    //MARK: - Messages
    
    class func loadMessages(for channel: SendBirdChannel?, _ completion: @escaping (Result<[String], Error>) -> Void) {
        let prevMessages = channel?.createPreviousMessageListQuery()

        prevMessages?.load(completionHandler: { messages, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let messages = messages else {
                completion(.failure(MessagedError(message: "Could not get messages in " + #function)))
                return
            }
            
            completion(.success(messages.map { $0.message }))
        })
    }
    
    class func sendMessage(from channel: SBDOpenChannel, message: String, completion: @escaping (Result<String, Error>) -> Void) {
        if message.isEmpty {
            completion(.failure(MessagedError(message: "Message is empty")))
            return
        }
        
        channel.sendUserMessage(message) { message, error in
            if let error = error {
                print("Error: \(error.localizedDescription) in " + #function)
                completion(.failure(error))
                return
            }
            
            if let message = message {
                completion(.success(message.message))
            }
        }
    }
    
}

extension SendBirdManager: SBDChannelDelegate {
    
    func channel(_ sender: SBDBaseChannel, didReceive message: SBDBaseMessage) {
        SendBirdManager.didHandleMessage?(message.message)
    }
    
}
