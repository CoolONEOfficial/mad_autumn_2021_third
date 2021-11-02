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
    @Published var isLoading = false
    
    func login() {
        guard email.contains("."), email.contains("@") else {
            alert.info = "Incorrect email"
            return
        }
        guard pass.isNotEmpty else {
            alert.info = "Pass is empty"
            return
        }
        
        isLoading = true
        nw.authLogin(email: email, pass: pass) { [self] err in
            isLoading = false
            if let err = err {
                alert.info = "Something went wrong!"
            }
        }
    }
}
