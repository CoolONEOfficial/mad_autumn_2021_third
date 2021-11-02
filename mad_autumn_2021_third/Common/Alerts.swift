//
//  ViewModel.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 02.11.2021.
//

import Foundation
import SwiftUI
import SwiftUIX

final class AlertInfo: ObservableObject {
    init(_ alert: Alert? = nil) {
        self.info = alert
    }
    
    @Published var info: Alert?
}

extension Alert: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    
    public init(stringLiteral value: StringLiteralType) {
        self.init(title: Text(value), message: nil, dismissButton: nil)
    }
}

class ViewModel: ObservableObject {
    var alert: AlertInfo
    
    init(_ alert: AlertInfo) {
        self.alert = alert
    }
}
