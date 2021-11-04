//
//  StartScreenModel.swift
//  mad_autumn_2021
//
//  Created by Nickolay Truhin on 31.10.2021.
//

import Foundation
import SwiftUI

class StartScreenModel: ViewModel {
    let nw = NetworkService.shared
    
    @Published var loginOpen = false
    
    func checkToken() {
        if nw.token?.accessTokenDate?.isInPast == true, let refresh = nw.token?.refreshToken, nw.token?.refreshTokenDate?.isInFuture == true {
            notifications.isLoading = true
            
            nw.refreshToken { [self] err in
                notifications.isLoading = false
                if let err = err {
                    loginOpen = true
                    //notifications.alert = "Refresh failed"
                }
            }
        }
    }
}
