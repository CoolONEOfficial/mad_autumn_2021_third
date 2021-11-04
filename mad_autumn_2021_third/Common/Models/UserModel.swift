//
//  UserModel.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 01.11.2021.
//

import Foundation

struct UserModel: Codable, Equatable {
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        lhs.aboutMyself == rhs.aboutMyself && lhs.topics == rhs.topics && lhs.name == rhs.name
    }
    
    var userId: String = ""
    var name: String = ""
    var aboutMyself: String?
    var avatar: URL?
    var topics: [TopicModel] = []
}
