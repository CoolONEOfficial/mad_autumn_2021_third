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
import SwiftDate
import MediaSwiftUI
import MediaCore

class ProfileScreenModel: ViewModel {
    let nm = NetworkService.shared
    
    @Published var profile: UserModel?
    @Published var selectedAvatarData: Data?
    
    var initialProfile: UserModel?
    
    @Published var party: String? = UserDefaults.standard.string(forKey: "party") {
        didSet {
            UserDefaults.standard.set(party, forKey: "party")
        }
    }

    @Published var topics: [TopicModel] = []
    
    @State var date: Date = .init()

    func isSelected(_ topic: TopicModel) -> Bool {
        profile?.topics.contains { $0.id == topic.id } == true
    }
    
    func toggleTopic(_ topic: TopicModel) {
        withAnimation {
            if isSelected(topic) {
                profile?.topics.removeAll { $0.id == topic.id }
            } else {
                profile?.topics.append(topic)
            }
        }
    }

    override init(_ notifications: Notifications) {
        super.init(notifications)
        
        let group = DispatchGroup()
        notifications.isLoading = true
        
        group.enter()
        nm.topics { result in
            defer { group.leave() }
            switch result {
            case let .success(model):
                self.topics = model

            case .failure:
                self.notifications.alert = "Не удалось получить topics"
            }
        }
        
        group.enter()
        nm.profile { [self] result in
            defer { group.leave() }
            switch result {
            case let .success(model):
                self.initialProfile = model
                self.profile = model

            case .failure:
                self.notifications.alert = "Не удалось получить данные пользователя"
            }
        }
        
        group.notify(queue: .main) {
            notifications.isLoading = false
        }
    }
    
    func didSelectPhoto(_ res: Result<[BrowserResult<Photo, UIImage>], Swift.Error>) {
        switch res {
        case let .success(arr):
            guard let first = arr.first else { fallthrough }
            
            switch first {
            case let .data(data):
                self.selectedAvatarData = data.jpegData(compressionQuality: 90)
                
            case let .media(val):
                val.data { [self] data in
                    switch data {
                    case let .success(data):
                        self.selectedAvatarData = data
                        
                    case .failure:
                        notifications.alert = "Не удалось получить выбранную картинку"
                    }
                }
            }
            
        case .failure:
            notifications.alert = "Не удалось получить выбранную картинку"
        }
    }

    func save(completion: @escaping (Bool) -> Void) {
        let group = DispatchGroup()
        notifications.isLoading = true
        
        var allSuccess = true
        
        if let data = selectedAvatarData {
            group.enter()
            nm.profileAvatar(avatar: data, completion: {
                defer { group.leave() }
                if !$0 {
                    self.notifications.alert = "Не удалось выгрузить картинку"
                    allSuccess = false
                }
            })
        }
        
        if profile != initialProfile, let profile = profile {
            group.enter()
            nm.profile(profile: profile) { res in
                defer { group.leave() }
                if case .failure = res {
                    self.notifications.alert = "Не удалось выгрузить профиль"
                    allSuccess = false
                }
            }
        }
        
        party = DateInRegion(date).toISO()
        
        group.notify(queue: .main) {
            self.notifications.isLoading = false
            completion(allSuccess)
        }
    }
}
