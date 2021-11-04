//
//  ContentView.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 31.10.2021.
//

import SwiftUI
import SwiftUIX

struct TabbedView: View {
    enum Tab: Int {
        case main = 0
        case chat
        
        @ViewBuilder
        func screen(_ notifications: Notifications) -> some View {
            switch self {
            case .main:
                MainScreen(vm: .init(notifications))
                
            case .chat:
                ChatListScreen(vm: .init(notifications))
            }
        }
    }

    @State var tab: Tab = .main
    @State var profile = false
    
    @EnvironmentObject var notifications: Notifications

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Rectangle().fill(Color.background).ignoresSafeArea()
                tab.screen(notifications)
                VStack(spacing: 0) {
                    Spacer()
                    HStack {
                        Button(action: {
                            tab = .main
                        }) {
                            Image("fire" + (tab == .main ? "Sel" : "")).resizable().scaledToFit().height(tab == .main ? 54 : 26)
                        }
                        Spacer()
                        Button(action: {
                            tab = .chat
                        }) {
                            Image("message" + (tab == .chat ? "Sel" : "")).resizable().scaledToFit().height(tab == .chat ? 54 : 26)
                        }
                        Spacer()
                        NavigationLink(isActive: $profile, destination: {
                            ProfileScreen(vm: .init(notifications), open: $profile)
                        }, label: {
                            Image("profile").resizable().scaledToFit().height(26)
                        })
                    }.padding(23).height(54)
                }
            }.navigationBarTitle("", displayMode: .inline).navigationBarHidden(true)
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
