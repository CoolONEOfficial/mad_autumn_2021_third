//
//  MyTextField.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 01.11.2021.
//

import SwiftUI
import SwiftUIX
import Introspect

//extension UIColor {
//    static var placeholderT
//}

struct ResizeableTextEditor: View {
    @Binding var text: String
    
    var body: some View {
        ZStack {
            TextEditor(text: $text)
            Text(text).opacity(0).padding(8)
        }
    }
}

struct MyTextField: View {
    init(_ placeholder: String, text: Binding<String>, _ contentType: UITextContentType? = nil, multiline: Bool = false) {
        self.placeholder = placeholder
        self._text = text
        self.contentType = contentType
        self.multiline = multiline
    }

    var placeholder: String
    @Binding var text: String
    var contentType: UITextContentType?
    var multiline: Bool

    @ViewBuilder
    var field: some View {
        let pass = contentType == .password || contentType == .newPassword
        if pass {
            SecureField("", text: $text)
        } else if !multiline {
            TextField("", text: $text)
        } else {
            ResizeableTextEditor(text: $text).padding(.vertical, -8).padding(.horizontal, -4)
        }
    }
    
    var body: some View {
        field.font(.plain).textContentType(contentType).padding(.horizontal, 24).padding(.vertical, 8)
            .background {
                RoundedRectangle(cornerRadius: 16).fill(Color.darkBg).overlay(alignment: .topLeading) {
                    if text.isEmpty {
                        Text(placeholder).font(.plain).padding(.horizontal, 24).padding(.vertical, 8)
                    }
                }
            }
    }
}

//struct MyTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        MyTextField()
//    }
//}
