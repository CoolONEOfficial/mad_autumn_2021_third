//
//  LoginScreen.swift
//  mad_autumn_2021
//
//  Created by Nickolay Truhin on 31.10.2021.
//

import SwiftUI
import SwiftUIX
import PureSwiftUI

struct SignupScreen: View {
    @StateObject var vm: SignupScreenModel
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Sign up").font(.title).fontSize(36).foregroundColor(.white).height(63)
                
                ScrollView(.vertical) {
                    VStack(spacing: 8) {
                        MyTextField("E-mail", text: $vm.email, .emailAddress)
                        MyTextField("Password", text: $vm.pass, .newPassword)
                        MyTextField("Repeat Password", text: $vm.passConfirm, .newPassword)
                        Spacer()
                    }
                }
                
                Button("Sign up") {
                    vm.signUp()
                }.buttonStyle(BS.general).padding(.bottom, 58)
            }.padding(.horizontal, 16)

            MyActivityIndicator(isLoading: vm.isLoading)
        }.navigationBarTransparent(true).navigationBarTitle("", displayMode: .inline)
    }
}

//struct SignupScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        SignupScreen()
//    }
//}
