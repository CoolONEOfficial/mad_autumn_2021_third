//
//  MainCardViewModel.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 02.11.2021.
//

import Foundation

class MainCardViewModel: ObservableObject {
    let nm = NetworkService.shared
    let data: UserModel
    
    let feedbackModel: FeedbackModel
    
    var notifications: Notifications

    init(_ notifications: Notifications, _ data: UserModel, didFeedback: @escaping () -> Void) {
        self.notifications = notifications
        self.data = data
        self.feedbackModel = .init(notifications)
        feedbackModel.didFeedback = didFeedback
    }

    func like() {
        feedbackModel.like(data)
    }
    
    func dislike() {
        feedbackModel.dislike(data)
    }
}
