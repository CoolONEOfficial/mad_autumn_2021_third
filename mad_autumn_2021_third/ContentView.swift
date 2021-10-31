//
//  ContentView.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 31.10.2021.
//

import SwiftUI


struct ContentView: View {
    enum Tab: Int {
        case main = 0
        case chat
        
        @ViewBuilder
        var screen: some View {
            switch self {
            case .main:
                MainScreen()
                
            case .chat:
                ChatScreen()
            }
        }
    }
    
    @State var tab: Tab = .main
    
    
    
    var body: some View {
        
        
        NavigationView {
            ZStack(alignment: .top) {
                Rectangle().ignoresSafeArea()
                tab.screen
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
                        NavigationLink(destination: {
                            ProfileScreen()
                        }, label: {
                            Image("profile").resizable().scaledToFit().height(26)
                        })
                    }.padding(23).height(54)
                    
                    
                }
            }.navigationBarHidden(true)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
