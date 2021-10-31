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
    let nm = NetworkService.shared
    var alertText = ""
    @Published var alert = false
    @Published var isLoading = false
    
    var liked: [UserModel] = (try? JSONDecoder().decode([UserModel].self, from: UserDefaults.standard.data(forKey: "liked") ?? .init())) ?? [] {
        didSet {
            UserDefaults.standard.set(try? JSONEncoder().encode(liked), forKey: "liked")
        }
    }
    
    @Published var chats: [ChatModel] = []
    
    init() {
        isLoading = true
        nm.chats { [self] res in
            self.isLoading = false
            switch res {
            case let .success(chats): break
                self.chats = chats
                
            case let .failure(err):
                self.alertText = "Ошибка при получении чатов"
                self.alert = true
            }
        }
    }
    
    func appear() {
        liked = (try? JSONDecoder().decode([UserModel].self, from: UserDefaults.standard.data(forKey: "liked") ?? .init())) ?? []
    }

}
