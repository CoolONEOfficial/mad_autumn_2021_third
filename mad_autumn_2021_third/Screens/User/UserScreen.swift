//
//  MainScreen.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 31.10.2021.
//

import SwiftUI
import SwiftUIX
import SwiftDate
import SDWebImageSwiftUI

struct UserScreen: View {

    var data: UserModel
    
    var like: () -> Void
    var dislike: () -> Void
    
    @Binding var isOpen: Bool

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Rectangle().fill(Color.background).ignoresSafeArea()
                PartRoundedRectangle(corners: [.bottomLeading, .bottomTrailing], cornerRadii: 40).fill(Color.accentBg).ignoresSafeArea().height(344)
                VStack(alignment: .center) {
                    AvatarView(url: data.avatar).width(168).height(168).padding(.top, 70).padding(.bottom, 10)
                    Text(data.name).font(.plain).fontSize(36).padding(.bottom, 55)
                    LazyHGrid(rows: [ .init(.adaptive(minimum:50)), .init(.adaptive(minimum:50)), .init(.adaptive(minimum:50)), .init(.adaptive(minimum:50)) ], spacing: 8) {
                        ForEach(data.topics, id: \.id) { topic in
                            Text(topic.title).font(.plain).fontSize(14).padding(.horizontal, 8).height(25).background(Color.orange).cornerRadius(12)
                        }
                    }.padding(.bottom, 30)
                    Text(data.aboutMyself ?? "").font(.plain).fontSize(14).foregroundColor(.white)
                    Spacer()
                    HStack {
                        Button(action: {
                            isOpen = false
                            dislike()
                        }) {
                            Image("dislike").resizable().scaledToFit()
                        }
                        Spacer()
                        Button(action: {
                            isOpen = false
                            like()
                        }) {
                            Image("like").resizable().scaledToFit()
                        }
                    }.height(54).padding(23).padding(.bottom, 100)
                }.padding(.horizontal, 21)
            }.navigationBarHidden(true)
            
        }
    }
}

//struct MainScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        MainScreen()
//    }
//}
