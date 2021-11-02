//
//  MyTextField.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 01.11.2021.
//

import SwiftUI

struct MyTextField: View {
    init(_ placeholder: String, text: Binding<String>, _ contentType: UITextContentType? = nil) {
        self.placeholder = placeholder
        self._text = text
        self.contentType = contentType
    }

    var placeholder: String
    @Binding var text: String
    var contentType: UITextContentType?

    @ViewBuilder
    var field: some View {
        if contentType == .password || contentType == .newPassword {
            SecureField("", text: $text)
        } else {
            TextField("", text: $text)
        }
    }
    
    var body: some View {
        field.textFieldStyle(TF.general($text, placeholder)).textContentType(contentType)
    }
}

//struct MyTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        MyTextField()
//    }
//}
