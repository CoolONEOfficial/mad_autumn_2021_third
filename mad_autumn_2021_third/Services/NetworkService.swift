//
//  NetworkService.swift
//  mad_autumn_2021
//
//  Created by Nickolay Truhin on 31.10.2021.
//

import Foundation
import Alamofire
import SwiftDate
import AlamofireNetworkActivityLogger
import SwiftUI
import SwiftUIX

class NetworkService: ObservableObject {
    static var shared: NetworkService = .init()

    private init() {
        AlamofireNetworkActivityLogger.NetworkActivityLogger.shared.startLogging()
        
        debugPrint("token is \(token) \(token?.accessTokenDate)")
    }

    deinit {
        AlamofireNetworkActivityLogger.NetworkActivityLogger.shared.stopLogging()
    }

    @Published
    var token: AuthResp? = (try? JSONDecoder().decode(AuthResp.self, from: UserDefaults.standard.data(forKey: "token") ?? .init())) {
        didSet {
            UserDefaults.standard.set(try? JSONEncoder().encode(token), forKey: "token")
        }
    }

    let baseUrl = "http://45.144.179.101/scare-me/api/mobile"

    var authorizationHeaders: HTTPHeaders {
        [ "Authorization": "Bearer " + (token?.accessToken ?? "") ]
    }
}
