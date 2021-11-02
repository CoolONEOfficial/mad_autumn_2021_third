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
    
    func signUp() {
        guard email.contains("."), email.contains("@") else {
            notifications.alert = "Incorrect email"
            return
        }
        guard pass == passConfirm else {
            notifications.alert = "Passes not match"
            return
        }
        guard pass.isNotEmpty else {
            notifications.alert = "Passes is empty"
            return
        }
        
        notifications.isLoading = true
        nw.authSignup(email: email, pass: pass) { [self] err in
            notifications.isLoading = false
            if let err = err {
                notifications.alert = "Something went wrong!"
                }
        }
    }
}
