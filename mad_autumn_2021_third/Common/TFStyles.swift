//
//  TFStyles.swift
//  mad_autumn_2021
//
//  Created by Nickolay Truhin on 31.10.2021.
//

import SwiftUI

struct TF {
    static let general = GenTextFieldStyle()
}

struct GenTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        RoundedRectangle(cornerRadius: 16).fill(Color.darkBg).overlay {
            configuration.padding(.horizontal, 24).font(.regular).fontSize(16)
        }.height(64)
    }
}
