//
//  StartScreenModel.swift
//  mad_autumn_2021
//
//  Created by Nickolay Truhin on 31.10.2021.
//

import Foundation

class LoginScreenModel: ViewModel {
    let nw = NetworkService.shared
    
    @Published var email = "coolone.official@gmail.com"
    @Published var pass = "12345678"
    
    func login() {
        guard email.contains("."), email.contains("@") else {
            notifications.alert = "Incorrect email"
            return
        }
        guard pass.isNotEmpty else {
            notifications.alert = "Pass is empty"
            return
        }
        
        notifications.isLoading = true
        nw.authLogin(email: email, pass: pass) { [self] err in
            notifications.isLoading = false
            if let err = err {
                notifications.alert = "Something went wrong!"
            }
        }
    }
}
