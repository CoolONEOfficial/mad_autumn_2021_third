//
//  UserModel.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 01.11.2021.
//

import Foundation

struct UserModel: Codable {
    let userId: String
    let name: String
    let aboutMyself: String?
    let avatar: URL?
    let topics: [TopicModel]
}
