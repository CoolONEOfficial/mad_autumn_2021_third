//
//  MainScreenModel.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 31.10.2021.
//

import Foundation
import Alamofire
import SwiftUI

class ChatScreenModel: ObservableObject {
    
    let chatModel: ChatModel
    
    let nm = NetworkService.shared
    
    @Published var text = ""
    
    @Published var messages: [MessageModel] = []
    
    var notifications: Notifications
    
    init(_ notifications: Notifications, _ chatModel: ChatModel) {
        self.notifications = notifications
        self.chatModel = chatModel

        notifications.isLoading = true
        nm.messages(chatId: chatModel.chat.id) { [self] res in
            self.notifications.isLoading = false
            switch res {
            case let .success(messages):
                self.messages = messages
                
            case let .failure(err):
                self.notifications.alert = "Ошибка при получении сообщений"
            }
        }
    }
    
    func send() {
        notifications.isLoading = true
        nm.sendMessage(chatId: chatModel.chat.id, text: text) { res in
            self.notifications.isLoading = false
            switch res {
            case let .success(message):
                self.text = ""
                self.messages.append(message)
                
            case let .failure(err):
                self.notifications.alert = "Ошибка при отправки сообщения"
            }
        }
    }
    
//    func appear() {
//        liked = (try? JSONDecoder().decode([UserModel].self, from: UserDefaults.standard.data(forKey: "liked") ?? .init())) ?? []
//    }

}
