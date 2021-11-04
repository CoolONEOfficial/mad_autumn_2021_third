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
    
    @Published var matches: Int = 0

    init(_ notifications: Notifications, _ data: UserModel, didFeedback: @escaping () -> Void) {
        self.notifications = notifications
        self.data = data
        self.feedbackModel = .init(notifications)
        feedbackModel.didFeedback = didFeedback
        
        nm.profile { result in
            switch result {
            case let .success(model):
                self.matches = model.topics?.filter { topic in data.topics?.contains { $0.id == topic.id } ?? false }.count ?? 0

            case .failure:
                self.notifications.alert = "Не удалось получить данные пользователя"
            }
        }
    }

    func like() {
        feedbackModel.like(data)
    }
    
    func dislike() {
        feedbackModel.dislike(data)
    }
}
