//
//  FeedbackModel.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 02.11.2021.
//

import Foundation

class FeedbackModel: ViewModel {
    let nm = NetworkService.shared
    
    var didFeedback: (() -> Void)? = nil
    
    var liked: [UserModel] = (try? JSONDecoder().decode([UserModel].self, from: UserDefaults.standard.data(forKey: "liked") ?? .init())) ?? [] {
        didSet {
            UserDefaults.standard.set(try? JSONEncoder().encode(liked), forKey: "liked")
        }
    }
    
    func like(_ data: UserModel) {
        liked.append(data)
        feedback(true, userId: data.userId)
    
    }
    
    func dislike(_ data: UserModel) {
        feedback(false, userId: data.userId)
    }
    
    func feedback(_ feedback: Bool, userId: String) {
        didFeedback?()
        
        //isLoading = true TODO: uncomment
        nm.feedback(feedback, userId: userId) { res in
            self.notifications.isLoading = false
            
            switch res {
            case let .success(users): break
               // self.users = users
                
            case let .failure(err): break
                //self.alert.info = "Ошибка при оценке" TODO: uncomment
            }
        }
    }
}
