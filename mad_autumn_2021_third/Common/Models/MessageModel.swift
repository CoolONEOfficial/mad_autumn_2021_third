//
//  MessageModel.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 01.11.2021.
//

import Foundation
import SwiftDate

struct MessageModel: Codable {
    let id: String
    
    let text: String
    let createdAt: DateInRegion
    let user: UserModel
    
}
