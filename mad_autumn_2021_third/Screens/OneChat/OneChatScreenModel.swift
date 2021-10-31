//
//  MainScreenModel.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 31.10.2021.
//

import Foundation
import Alamofire
import SwiftUI

class OneChatScreenModel: ObservableObject {
    
    let chatModel: ChatModel
    
    let nm = NetworkService.shared
    var alertText = ""
    @Published var alert = false
    @Published var isLoading = false
    
    @Published var messages: [MessageModel] = []
    
    init(_ chatModel: ChatModel) {
        self.chatModel = chatModel
        isLoading = true
        nm.messages(chatId: chatModel.chat.id) { [self] res in
            self.isLoading = false
            switch res {
            case let .success(messages): break
                self.messages = messages
                
            case let .failure(err):
                self.alertText = "Ошибка при получении сообщений"
                self.alert = true
            }
        }
    }
    
//    func appear() {
//        liked = (try? JSONDecoder().decode([UserModel].self, from: UserDefaults.standard.data(forKey: "liked") ?? .init())) ?? []
//    }

}