//
//  MainScreenModel.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 31.10.2021.
//

import Foundation
import Alamofire
import SwiftUI

class MainScreenModel: ViewModel {
    let nm = NetworkService.shared
    @Published var isLoading = false
    @Published var users: [UserModel] = []
    var usersOffset = 0
    
    var liked: [UserModel] = (try? JSONDecoder().decode([UserModel].self, from: UserDefaults.standard.data(forKey: "liked") ?? .init())) ?? [] {
        didSet {
            UserDefaults.standard.set(try? JSONEncoder().encode(liked), forKey: "liked")
        }
    }

    override init(_ alert: AlertInfo) {
        super.init(alert)
        
        guard Alamofire.NetworkReachabilityManager.default?.isReachable == true else {
            self.alert.info = "Нет интернета!"
            return
        }

        loadUsers()
    }
    
    func loadUsers() {
        isLoading = users.isEmpty
        nm.users(offset: usersOffset) { [self] res in
            isLoading = false
            switch res {
            case let .success(users):
                self.users = users
                self.usersOffset += users.count
                
            case .failure:
                self.alert.info = "Ошибка при получении юзеров"
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
        _ = withAnimation {
            users.remove(at: 0)
            if users.count <= 4 {
                loadUsers()
            }
        }
        
        //isLoading = true TODO: uncomment
        nm.feedback(feedback, userId: userId) { res in
            self.isLoading = false
            
            switch res {
            case let .success(users): break
               // self.users = users
                
            case let .failure(err): break
                //self.alert.info = "Ошибка при оценке" TODO: uncomment
            }
        }
    }
}
