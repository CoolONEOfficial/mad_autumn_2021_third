//
//  MainCardView.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 02.11.2021.
//

import SwiftUI
import SwiftUIX
import PureSwiftUI
import SDWebImageSwiftUI

struct MainCardView: View {
    let vm: MainCardViewModel
    let isLast: Bool
    let index: Int
    
    @State var offset = CGPoint(x: 0, y: 0)
    var dragOffset: CGFloat = 50
    
    @State var color: Color?
    
    @State var showUser = false

    var overlayColor: Color {
        offset.x < -dragOffset
            ? Color.red : offset.x > dragOffset
                ? Color.green
            : Color.clear
    }
    
    var overlay: some View {
        overlayColor.opacity(isLast ? 0.5 : 0)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            WebImage(url: vm.data.avatar).resizable().fill().background(Color.background).overlay(overlay).cornerRadius(13).clipped()
            HStack {
                Text(vm.data.name).font(.plain).fontSize(21).foregroundColor(.white)
                Spacer()
                Text("5 Matches").font(.plain).fontSize(21).foregroundColor(.accentRed)
            }.padding(21).background(Color.accentBg).cornerRadius(13)
        }.padding(.bottom, CGFloat(index) * 13).padding(.horizontal, max(0, CGFloat(3 - index) * 13))
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
            .id(vm.data.userId)
        NavigationLink("", isActive: $showUser) {
            UserScreen(data: vm.data, like: vm.like, dislike: vm.dislike, isOpen: $showUser)
        }.hidden()
    
    }
}
