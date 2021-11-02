//
//  NetworkService+signup.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 01.11.2021.
//

import Foundation
import Alamofire
import SwiftDate

var dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ'['zzz']'"

struct AuthResp: Codable {
    let accessToken: String
    let accessTokenExpiredAt: String
    let refreshToken: String
    let refreshTokenExpiredAt: String

    var accessTokenDate: DateInRegion? { accessTokenExpiredAt.toDate(dateFormat) }
    var refreshTokenDate: DateInRegion? { refreshTokenExpiredAt.toDate(dateFormat) }
}

extension NetworkService {
    

    func authLogin(email: String, pass: String, completion: @escaping (Error?) -> Void) {
        AF.request(baseUrl + "/v1/auth/login", method: .post, parameters: [ "email": email, "password": pass ] as Parameters, encoding: JSONEncoding.default).responseDecodable(of: AuthResp.self) { resp in
            switch resp.result {
            case var .success(res):
                debugPrint("date \(res.accessTokenExpiredAt) \(res.accessTokenDate)")
                self.token = res
                debugPrint("date \(self.token?.accessTokenExpiredAt) \(self.token?.accessTokenDate)")
                completion(nil)
                
            case let .failure(err):
                completion(err)
            }
        }
    }
    
    func authSignup(email: String, pass: String, completion: @escaping (Error?) -> Void) {
        AF.request(baseUrl + "/v1/auth/register", method: .post, parameters: [ "email": email, "password": pass ] as Parameters, encoding: JSONEncoding.default).responseDecodable(of: AuthResp.self) { resp in
            switch resp.result {
            case let .success(res):
                self.token = res
                completion(nil)
                
            case let .failure(err):
                completion(err)
            }
        }
    }

    func refreshToken(completion: @escaping (Error?) -> Void) {
        AF.request(baseUrl + "/v1/auth/refresh", method: .post, parameters: [ "refreshToken": token?.refreshToken as Any ] as Parameters, encoding: JSONEncoding.default).responseDecodable(of: AuthResp.self) { resp in
            switch resp.result {
            case let .success(res):
                self.token = res
                completion(nil)
                
            case let .failure(err):
                completion(err)
            }
        }
    }
}
