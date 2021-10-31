//
//  MainScreenModel.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 31.10.2021.
//

import Foundation
import Alamofire
import SwiftUI

class MainScreenModel: ObservableObject {
    let nm = NetworkService.shared
    var alertText = ""
    @Published var alert = false
    @Published var isLoading = false
    
    @Published var users: [UserModel] = []
    
    
    var liked: [UserModel] = (try? JSONDecoder().decode([UserModel].self, from: UserDefaults.standard.data(forKey: "liked") ?? .init())) ?? [] {
        didSet {
            UserDefaults.standard.set(try? JSONEncoder().encode(liked), forKey: "liked")
        }
    }

    init() {
        guard Alamofire.NetworkReachabilityManager.default?.isReachable == true else {
            self.alertText = "Нет интернета!"
            self.alert = true
            return
        }

        isLoading = true
        
        nm.users { [self] res in
            isLoading = false
            switch res {
            case let .success(users):
                self.users = users
                
            case let .failure(err):
                self.alertText = "Ошибка при получении юзеров"
                self.alert = true
            }
        }
    }
    
    func like() {
        
        guard let user = users.first else { return }
        liked.append(user)
        feedback(true)
    
    }
    
    func dislike() {
        feedback(false)
    }
    
    func feedback(_ feedback: Bool) {
        guard let userId = users.first?.userId else { return }
        withAnimation {
            users.remove(at: 0)
        }
        
        isLoading = true
        nm.feedback(feedback, userId: userId) { res in
            self.isLoading = false
            
            switch res {
            case let .success(users): break
               // self.users = users
                
            case let .failure(err):
                self.alertText = "Ошибка при оценке"
                self.alert = true
            }
        }
    }
}