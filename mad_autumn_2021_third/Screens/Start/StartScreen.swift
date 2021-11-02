//
//  StartScreen.swift
//  mad_autumn_2021
//
//  Created by Nickolay Truhin on 31.10.2021.
//

import SwiftUI
import SwiftUIX
import PureSwiftUI

struct StartScreen: View {
    
    @StateObject var vm: StartScreenModel
    
    @State var signup = false
    @State var login = false
    
    @EnvironmentObject var alert: AlertInfo
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.background.ignoresSafeArea()
                VStack(spacing: 0) {
                    ZStack {
                        Image("previewText") // TODO: anims
                    }.maxHeight(.infinity)
                    
                    Button("Sign up") {
                        signup = true
                    }.buttonStyle(BS.general).padding(.bottom, 24)
                    Button("Already have an account?") {
                        login = true
                    }.buttonStyle(BS.dark).padding(.bottom, 8)
                    Button("Sign In") {
                        login = true
                    }.buttonStyle(BS.underlined).padding(.bottom, 37)
                    NavigationLink("", isActive: $signup, destination: {
                        SignupScreen(vm: .init(alert))
                    }).hidden()
                    NavigationLink("", isActive: $login, destination: {
                        LoginScreen(vm: .init(alert))
                    }).hidden()
                }.ignoresSafeArea(SafeAreaRegions.all, edges: .top).padding(.horizontal, 16).navigationBarTransparent(true)
                
                MyActivityIndicator(isLoading: vm.isLoading)
            }.navigationTitle("")
        }.onAppear {
            vm.checkToken()
        }
    }
}

//struct StartScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        StartScreen()
//    }
//}
