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
    
    @State var offset = CGPoint(x: 0, y: 0)
    @State var color: Color?
    
    @State var showUser = false
    
    var dragOffset: CGFloat = 50

    var overlayColor: Color {
        offset.x < -dragOffset
            ? Color.red : offset.x > dragOffset
                ? Color.green
            : Color.clear
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            PartRoundedRectangle(corners: [.bottomLeading, .bottomTrailing], cornerRadii: 40).fill(Color.accentBg).ignoresSafeArea().height(344)
            VStack(alignment: .leading, spacing: 0) {
                Text("Trick or Treat?").font(.plain).fontSize(36).foregroundColor(.white)
                ZStack(alignment: .top) {
                    ForEach(enumerating: Array(vm.users.prefix(3).reversed().enumerated()), id: \.offset) { index, entry in
                        let isLast = 2 == index
                        let user = entry.element
                        CardView(data: user, overlay: color.opacity(isLast ? 0.5 : 0)).padding(.bottom, CGFloat(index) * 13).padding(.horizontal, max(0, CGFloat(3 - index) * 13))
                            .gesture(
                                DragGesture(minimumDistance: .zero).onChanged { value in
                                    self.offset.x += value.location.x - value.startLocation.x
                                    self.offset.y += value.location.y - value.startLocation.y
                                    
                                    withAnimation {
                                        self.color = self.overlayColor
                                    }
                                }.onEnded { value in
                                    
                                    if offset.x < -dragOffset {
                                        vm.dislike()
                                    } else if offset.x > dragOffset {
                                        vm.like()
                                    }
                                    
                                    withAnimation {
                                        self.color = nil
                                        self.offset = .zero
                                    }
                                }.simultaneously(with: TapGesture.init().onEnded { _ in
                                    showUser = true
                                })
                            )
                            .offset(x: isLast ? offset.x : 0, y: isLast ? offset.y / 3 : 0)
                            .id(user.userId)
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
            
            MyActivityIndicator(isLoading: vm.isLoading)
            if let user = vm.users.first {
                NavigationLink("", isActive: $showUser) {
                    UserScreen(data: user, like: vm.like, dislike: vm.dislike, isOpen: $showUser)
                }.hidden()
            }
        }.navigationBarTitle("")
    }
}

//struct MainScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        MainScreen()
//    }
//}
