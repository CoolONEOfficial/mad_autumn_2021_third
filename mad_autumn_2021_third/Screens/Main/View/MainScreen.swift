//
//  MainScreen.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 31.10.2021.
//

import SwiftUI
import SwiftUIX

struct MainScreen: View {
    
    @StateObject var vm: MainScreenModel
    
    @EnvironmentObject var notifications: Notifications
    
    var body: some View {
        ZStack(alignment: .top) {
            PartRoundedRectangle(corners: [.bottomLeading, .bottomTrailing], cornerRadii: 40).fill(Color.accentBg).ignoresSafeArea().height(344)
            VStack(alignment: .leading, spacing: 0) {
                Text("Trick or Treat?").font(.plain).fontSize(36).foregroundColor(.white)
                ZStack(alignment: .top) {
                    ForEach(enumerating: Array(vm.userModels.enumerated()), id: \.offset) { index, entry in
                        let isLast = 2 == index
                        let vm = entry.element
                        MainCardView(vm: vm, isLast: isLast, index: index)
                    }
                }
                .height(508)
                
                HStack {
                    Button(action: {
                        vm.dislike()
                    }) {
                        Image("dislike").resizable().scaledToFit()
                    }
                    Spacer()
                    Button(action: {
                        vm.like()
                    }) {
                        Image("like").resizable().scaledToFit()
                    }
                }.height(54).padding(23)
                
                
            }.padding(.horizontal, 21)
            
            
        }.navigationBarTitle("")
    }
}

//struct MainScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        MainScreen()
//    }
//}
