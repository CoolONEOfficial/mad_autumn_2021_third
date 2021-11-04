//
//  ChatModel.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 01.11.2021.
//

import Foundation

struct ChatModel: Codable {
    let chat: ChatInfo
    
    struct ChatInfo: Codable {
        let id: String
        let title: String
        let avatar: URL?
    }
    
    let lastMessage: MessageModel?
}
