//
//  TFStyles.swift
//  mad_autumn_2021
//
//  Created by Nickolay Truhin on 31.10.2021.
//

import SwiftUI

struct TF {
    static func general(_ text: Binding<String>, _ placeholder: String? = nil) -> GenTextFieldStyle {
        .init(text: text, placeholder: placeholder)
    }
}

struct GenTextFieldStyle: TextFieldStyle {
    @Binding var text: String
    var placeholder: String?
    
    @ViewBuilder
    func content(_ configuration: TextField<_Label>) -> some View {
        if text.isEmpty, let placeholder = placeholder {
            Text(placeholder).foregroundColor(.white)
        }
        configuration.foregroundColor(.white)
    }

    func _body(configuration: TextField<_Label>) -> some View {
        RoundedRectangle(cornerRadius: 16).fill(Color.darkBg).overlay {
            ZStack(alignment: .leading) {
                content(configuration).padding(.horizontal, 24).font(.plain).fontSize(16)
            }
        }.height(64)
    }
}
