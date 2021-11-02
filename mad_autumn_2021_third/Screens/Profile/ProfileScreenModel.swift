//
//  MainScreenModel.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 31.10.2021.
//

import Foundation
import Alamofire
import SwiftUI
import SwiftUIX

class ProfileScreenModel: ViewModel {
    let nm = NetworkService.shared
    @Published var isLoading = false
    
    @Published var party: String? = UserDefaults.standard.string(forKey: "party") {
        didSet {
            UserDefaults.standard.set(party, forKey: "party")
        }
    }
    
//    init() {
////        guard Alamofire.NetworkReachabilityManager.default?.isReachable == true else {
////            self.alert.info = "Нет интернета!"
////            self.alert = true
////            return
////        }
////
////        isLoading = true
////
////        nm.users { [self] res in
////            isLoading = false
////            switch res {
////            case let .success(users):
////                self.users = users
////
////            case let .failure(err):
////                self.alert.info = "Ошибка при получении юзеров"
////                self.alert = true
////            }
////        }
//    }
//    
//    func like() {
//    
//        feedback(true)
//    
//    }
//    
//    func dislike() {
//        feedback(false)
//    }
//    
//    func feedback(_ feedback: Bool) {
//        guard let userId = users.first?.userId else { return }
//        withAnimation {
//            users.remove(at: 0)
//        }
//        
//        isLoading = true
//        nm.feedback(feedback, userId: userId) { res in
//            self.isLoading = false
//            
//            switch res {
//            case let .success(users): break
//               // self.users = users
//                
//            case let .failure(err):
//                self.alert.info = "Ошибка при оценке"
//                self.alert = true
//            }
//        }
//    }
}
