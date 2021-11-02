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
    let feedbackModel: FeedbackModel
    let usersModel: UsersModel

    var notifications: Notifications

    var userModels: [MainCardViewModel] {
        usersModel.users.prefix(3).map { MainCardViewModel.init(notifications, $0, didFeedback: usersModel.didFeedback) }.reversed()
    }
    
    init(_ notifications: Notifications) {
        self.notifications = notifications
        self.feedbackModel = .init(notifications)
        self.usersModel = .init(notifications)
        self.feedbackModel.didFeedback = usersModel.didFeedback
        self.usersModel.loadUsers()
    }

    func like() {
        guard let data = usersModel.users.first else { return }
        feedbackModel.like(data)
    }

    func dislike() {
        guard let data = usersModel.users.first else { return }
        feedbackModel.dislike(data)
    }
}
