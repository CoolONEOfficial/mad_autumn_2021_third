//
//  MainScreen.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 31.10.2021.
//

import SwiftUI
import SwiftUIX
import SDWebImageSwiftUI

struct ChatListScreen: View {
    
    @StateObject var vm: ChatListScreenModel
    
    @State var openChat = false
    @State var chat: ChatModel?
    
    @EnvironmentObject var notifications: Notifications
    
    var body: some View {
       // NavigationView {
            ZStack(alignment: .top) {
                Rectangle().fill(Color.background).ignoresSafeArea()
                
                ScrollView(.vertical) {
                    LazyVStack(alignment: .leading) {
                        Text("Last").font(.plain).fontSize(36).foregroundColor(.white)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 16) {
                                ForEach(enumerating: Array(vm.liked.sorted { $0.name < $1.name }.enumerated()), id: \.offset) { index, entry in
                                    let user = entry.element
                                    VStack(spacing: 8) {
                                        AvatarView(url: user.avatar).height(82).width(82).scaledToFill().background(Color.darkOrange).cornerRadius(41)
                                        Text(user.name).font(.plain).foregroundColor(.white)
                                    }.width(82)
                                }
                            }
                        }.height(115)
                        
                        Text("Messages").font(.plain).fontSize(36).foregroundColor(.white)
                        
                        ForEach(enumerating: Array(vm.chats.enumerated()), id: \.offset) { index, entry in
                            let chat = entry.element
                            
                            HStack(spacing: 16) {
                                AvatarView(url: chat.chat.avatar).scaledToFill().height(82).width(82).cornerRadius(41)
                                
                                VStack(spacing: 8) {
                                    Text(chat.chat.title).font(.plain).fontSize(16).foregroundColor(.white)//.lineLimit(1)
                                    Text(chat.lastMessage.text).font(.plain).fontSize(16).foregroundColor(.white)//.lineLimit(2)
                                }
                            }.height(82).onTapGesture {
                                self.chat = chat
                                self.openChat = true
                            }
                        }
                    }
                    if let chat = chat {
                    NavigationLink("", isActive: $openChat) {
                        ChatScreen(vm: .init(notifications, chat ))
                    }.hidden()
                    }
                }.padding(.horizontal, 21)
                
                
            }.navigationBarHidden(true)
            .onAppear {
                vm.appear()
            }
            
      //  }
    }
}

//struct MainScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        MainScreen()
//    }
//}
