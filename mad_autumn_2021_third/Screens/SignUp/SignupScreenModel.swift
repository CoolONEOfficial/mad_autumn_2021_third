//
//  StartScreenModel.swift
//  mad_autumn_2021
//
//  Created by Nickolay Truhin on 31.10.2021.
//

import Foundation

class SignupScreenModel: ViewModel {
    let nw = NetworkService.shared
    
    @Published var email = ""
    @Published var pass = ""
    @Published var passConfirm = ""
    @Published var isLoading = false
    
    func signUp() {
        guard email.contains("."), email.contains("@") else {
            alert.info = "Incorrect email"
            return
        }
        guard pass == passConfirm else {
            alert.info = "Passes not match"
            return
        }
        guard pass.isNotEmpty else {
            alert.info = "Passes is empty"
            return
        }
        
        isLoading = true
        nw.authSignup(email: email, pass: pass) { [self] err in
            isLoading = false
            if let err = err {
                alert.info = "Something went wrong!"
                }
        }
    }
}
