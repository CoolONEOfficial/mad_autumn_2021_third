//
//  MainScreenModel.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 31.10.2021.
//

import Foundation
import Alamofire
import SwiftUI

class ChatListScreenModel: ViewModel {
    let nm = NetworkService.shared
    
    var liked: [UserModel] = [] {
        didSet {
            UserDefaults.standard.set(try? JSONEncoder().encode(liked), forKey: "liked")
        }
    }
    
    @Published var chats: [ChatModel] = [] {
        didSet {
            debugPrint("set \(chats.count)")
        }
    }

    func appear() {
        liked = (try? JSONDecoder().decode([UserModel].self, from: UserDefaults.standard.data(forKey: "liked") ?? .init())) ?? []
        
        notifications.isLoading = true
        nm.chats { [self] res in
            self.notifications.isLoading = false
            switch res {
            case let .success(chats):
                self.chats = chats
                
            case let .failure(err):
                self.notifications.alert = "Ошибка при получении чатов"
            }
        }
    }

}
