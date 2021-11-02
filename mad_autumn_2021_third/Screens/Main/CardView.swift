//
//  CardView.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 31.10.2021.
//

import SwiftUI
import SwiftUIX
import PureSwiftUI
import SDWebImageSwiftUI

struct CardView<T: View>: View {
    let data: UserModel
    let overlay: T
    
    var body: some View {
        ZStack(alignment: .bottom) {
            WebImage(url: data.avatar).resizable().fill().background(Color.background).overlay(overlay).cornerRadius(13).clipped()
            HStack {
                Text(data.name).font(.plain).fontSize(21).foregroundColor(.white)
                Spacer()
                Text("5 Matches").font(.plain).fontSize(21).foregroundColor(.accentRed)
            }.padding(21).background(Color.accentBg).cornerRadius(13)
        }
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
//}
