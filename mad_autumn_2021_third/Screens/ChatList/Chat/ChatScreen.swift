//
//  MainScreen.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 31.10.2021.
//

import SwiftUI
import SwiftUIX
import SDWebImageSwiftUI

struct ChatScreen: View {
    
    @StateObject var vm: ChatScreenModel
    
//    @State var offset = CGPoint(x: 0, y: 0)
//    
//    @State var showUser = false
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(enumerating: Array(vm.messages.enumerated()), id: \.offset) { index, entry in
                    let message = entry.element
                    
                    Text(message.text)
                }
            }
        }
       // NavigationView {
//            ZStack(alignment: .top) {
//                Rectangle().ignoresSafeArea()
//
//                ScrollView(.vertical) {
//                    LazyVStack(alignment: .leading) {
//                        Text("Last").font(.plain).fontSize(36).foregroundColor(.white)
//
//                        ScrollView(.horizontal) {
//                            LazyHStack(spacing: 16) {
//                                ForEach(enumerating: Array(vm.liked.sorted { $0.name < $1.name }.enumerated()), id: \.offset) { index, entry in
//                                    let user = entry.element
//                                    VStack(spacing: 8) {
//                                        WebImage(url: user.avatar).resizable().scaledToFill().height(82).width(82).cornerRadius(41)
//                                        Text(user.name).font(.plain).fontSize(14).foregroundColor(.white)
//                                    }
//                                }
//                            }
//                        }.height(115)
//
//                        Text("Messages").font(.plain).fontSize(36).foregroundColor(.white)
//
//                        ForEach(enumerating: Array(vm.chats.enumerated()), id: \.offset) { index, entry in
//                            let chat = entry.element
//
//                            HStack(spacing: 16) {
//                                WebImage(url: chat.chat.avatar).resizable().scaledToFill().height(82).width(82).cornerRadius(41)
//
//                                VStack(spacing: 8) {
//                                    Text(chat.chat.title).font(.plain).fontSize(16).foregroundColor(.white)//.lineLimit(1)
//                                    Text(chat.lastMessage.text).font(.plain).fontSize(16).foregroundColor(.white)//.lineLimit(2)
//                                }
//                            }.height(82)
//                        }
//                    }
//                }.alert(isPresented: $vm.alert) {
//                    Alert(title: "Message!", message: vm.alertText, dismissButtonTitle: "OK")
//                }.padding(.horizontal, 21)
//                if vm.isLoading {
//                    ActivityIndicator().animated(true)
//                }
//            }.navigationBarHidden(true)
//            .onAppear {
//                vm.appear()
//            }
            
      //  }
    }
}

//struct MainScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        MainScreen()
//    }
//}
