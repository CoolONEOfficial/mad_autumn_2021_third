//
//  LoginScreen.swift
//  mad_autumn_2021
//
//  Created by Nickolay Truhin on 31.10.2021.
//

import SwiftUI
import SwiftUIX

struct LoginScreen: View {
    @StateObject var vm: LoginScreenModel
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 0) {
                Text("Sign in").font(.title).foregroundColor(.white).height(63)
                
                ScrollView(.vertical) {
                    VStack(spacing: 8) {
                        MyTextField("E-mail", text: $vm.email, .emailAddress)
                        MyTextField("Password", text: $vm.pass, .password)
                        Spacer()
                    }
                }
                
                Button("Sign in") {
                    vm.login()
                }.buttonStyle(BS.general).padding(.bottom, 58)
            }.padding(.horizontal, 16).navigationBarTransparent(true)
            
            MyActivityIndicator(isLoading: vm.isLoading)
        }.navigationBarTransparent(true).navigationBarTitle("", displayMode: .inline)
    
    }
}
//
//struct LoginScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginScreen(vm: <#LoginScreenModel#>)
//    }
//}
