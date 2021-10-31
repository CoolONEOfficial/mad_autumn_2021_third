//
//  MainScreen.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 31.10.2021.
//

import SwiftUI
import SwiftUIX



struct MainScreen: View {
    
    @StateObject var vm = MainScreenModel()
    
    @State var offset = CGPoint(x: 0, y: 0)
    
    @State var showUser = false
    
    var body: some View {
        ZStack(alignment: .top) {
            PartRoundedRectangle(corners: [.bottomLeading, .bottomTrailing], cornerRadii: 40).fill(Color.accentBg).ignoresSafeArea().height(344)
            VStack(alignment: .leading, spacing: 0) {
                Text("Trick or Treat?").font(.regular).fontSize(36).foregroundColor(.white)
                ZStack(alignment: .top) {
                    ForEach(enumerating: Array(vm.users.prefix(3).reversed().enumerated()), id: \.offset) { index, user in
                        let isLast = 2 == index
                        CardView(data: user.element).padding(.bottom, CGFloat(index) * 13).padding(.horizontal, max(0, CGFloat(3 - index) * 13))
                            .gesture(
                                DragGesture(minimumDistance: .zero).onChanged { value in
                                    self.offset.x += value.location.x - value.startLocation.x
                                    self.offset.y += value.location.y - value.startLocation.y
                                }.onEnded { value in
                                    
                                    if offset.x < -50 {
                                        vm.dislike()
                                    } else if offset.x > 50 {
                                        vm.like()
                                    }
                                    
                                    withAnimation {
                                        self.offset = .zero
                                    }
                                }.simultaneously(with: TapGesture.init().onEnded { _ in
                                    showUser = true
                                })
                            )
                            .offset(x: isLast ? offset.x : 0, y: isLast ? offset.y : 0)
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
                
                
            }.alert(isPresented: $vm.alert) {
                Alert(title: "Message!", message: vm.alertText, dismissButtonTitle: "OK")
            }.padding(.horizontal, 21)
            if vm.isLoading {
                ActivityIndicator().animated(true)
            }
            if let user = vm.users.first {
                NavigationLink("", isActive: $showUser) {
                    UserScreen(data: user, like: vm.like, dislike: vm.dislike, isOpen: $showUser)
                }.hidden()
            }
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
