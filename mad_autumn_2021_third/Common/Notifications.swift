//
//  ViewModel.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 02.11.2021.
//

import Foundation
import SwiftUI
import SwiftUIX
import Alamofire

final class Notifications: ObservableObject {
    @Published var alert: Alert? = nil
    @Published var isLoading = false
}

extension Alert: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    
    public init(stringLiteral value: StringLiteralType) {
        self.init(title: Text(value), message: nil, dismissButton: nil)
    }
}

class ViewModel: ObservableObject {
    var notifications: Notifications
    
    init(_ notifications: Notifications) {
        self.notifications = notifications

        guard Alamofire.NetworkReachabilityManager.default?.isReachable == true else {
            self.notifications.alert = "Нет интернета!"
            return
        }
    }

    func onAppear() {
        notifications.isLoading = false
        notifications.alert = nil
    }
}
