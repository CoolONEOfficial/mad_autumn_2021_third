//
//  UsersModel.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 02.11.2021.
//

import Foundation
import Alamofire
import SwiftUI

class UsersModel: ViewModel {
    let nm = NetworkService.shared
    
    @Published var users: [UserModel] = []
    var usersOffset = 0

    func didFeedback() {
        _ = withAnimation {
            users.remove(at: 0)
            if users.count <= 4 {
                loadUsers()
            }
        }
    }

    func loadUsers() {
        notifications.isLoading = users.isEmpty
        nm.users(offset: usersOffset) { [self] res in
            notifications.isLoading = false
            switch res {
            case let .success(users):
                self.users = users
                self.usersOffset += users.count
                
            case .failure:
                self.notifications.alert = "Ошибка при получении юзеров"
            }
        }
    }
}
