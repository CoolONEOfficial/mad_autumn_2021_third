//
//  MessageView.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 05.11.2021.
//

import SwiftUI

struct MessageView: View {
    let message: MessageModel
    let fromMe: Bool
    
    var body: some View {
        VStack {
            Text(message.text).font(.plain).foregroundColor(fromMe ? .black : .white).padding(.horizontal, 14).padding(fromMe ? .trailing : .leading, 8).padding(.vertical, 12).maxWidth(250)
                .background {
                Image("messageMask").renderingMode(.template).resizable(capInsets: .init(top: 30, leading: 55, bottom: 30, trailing: 30)).foregroundColor(fromMe ? .orange : .accentBg)
                    .scaleEffect(.init(width: fromMe ? -1 : 1, height: 1))
            }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: .init(id: "", text: "test fsdhfsdhf\nkhf sfk shf hkfhskdf", user: .init()), fromMe: true)
    }
}
