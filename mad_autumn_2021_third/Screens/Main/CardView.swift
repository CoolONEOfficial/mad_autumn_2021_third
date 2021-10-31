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

struct CardView: View {
    let data: UserModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            WebImage(url: data.avatar).resizable().fill().cornerRadius(13).clipped()
            HStack {
                Text(data.name).font(.regular).fontSize(21).foregroundColor(.white)
                Spacer()
                Text("5 Matches").font(.regular).fontSize(21).foregroundColor(.accentRed)
            }.padding(21).background(Color.accentBg).cornerRadius(13)
        }
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
//}
