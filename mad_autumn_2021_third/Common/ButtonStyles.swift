//
//  ButtonStyles.swift
//  mad_autumn_2021
//
//  Created by Nickolay Truhin on 31.10.2021.
//

import Foundation
import SwiftUI
import SwiftUIX
import PureSwiftUI

struct BS {
    static let general = GeneralButtonStyle()
    static let underlined = UnderlinedButtonStyle()
    static let dark = DarkButtonStyle()
}

struct GeneralButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        RoundedRectangle(cornerRadius: 16).fill(.orange).overlay {
            configuration.label.foregroundColor(.darkText).font(.regular).fontSize(16)
        }.height(56).scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}

struct UnderlinedButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.foregroundColor(.orange).font(.regular).fontSize(16).overlay(alignment: .bottom) {
            Rectangle().fill(Color.orange).height(1).maxWidth(.infinity)
        }.scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}

struct DarkButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.foregroundColor(.darkOrange).font(.regular).fontSize(16).scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}
