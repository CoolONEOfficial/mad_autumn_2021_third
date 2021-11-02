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
    var isLoading = false
    
    func checkToken() {
        if nw.token?.accessTokenDate?.isInPast == true, let refresh = nw.token?.refreshToken, nw.token?.refreshTokenDate?.isInFuture == true {
            isLoading = true
            
            nw.refreshToken { [self] err in
                isLoading = false
                if let err = err {
                    alert.info = "Refresh failed"
                }
            }
        }
    }
}
