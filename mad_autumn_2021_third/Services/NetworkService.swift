//
//  NetworkService.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 31.10.2021.
//

import Foundation



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

class NetworkService {
    static var shared: NetworkService = .init()
    
    init() {
        AlamofireNetworkActivityLogger.NetworkActivityLogger.shared.startLogging()
        
    }
    
    var token: LoginResp? = .init(accessToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI3NWQ3YWQ2My1hMjc3LTQ1MzItOTU3MS1hN2MxNDhmZWY5YmYiLCJpc3MiOiJodHRwOi8vMC4wLjAuMDo4MDgwIiwiZXhwIjoxNjM1Njk3NzQ4LCJ1c2VyIjoiNzVkN2FkNjMtYTI3Ny00NTMyLTk1NzEtYTdjMTQ4ZmVmOWJmIn0.Z6i54goP105vubuiq5fabo2O7M61E6Ebd9PLkonHz1I", accessTokenExpiredAt: .init() + 100.years, refreshToken: "RAeHNz81HM7J0FJqWfBuk6MSPsqr3SkfvX/WPwZlrPVIlPPkpcvMvexA+JlQq3Tb8hr5/2JHqlX4c8vmDIQPVw==", refreshTokenExpiredAt: .init() + 100.years)
    
    var baseUrl = "http://45.144.179.101/scare-me/api/mobile"
    
    struct LoginResp: Decodable {
        let accessToken: String
        let accessTokenExpiredAt: DateInRegion
        let refreshToken: String
        let refreshTokenExpiredAt: DateInRegion
    }
    
    func authLogin(email: String, pass: String, completion: @escaping (Error?) -> Void) {
        AF.request(baseUrl + "/v1/auth/login", method: .post, parameters: [ "email": email, "password": pass ] as Parameters, encoding: JSONEncoding.default).responseDecodable(of: LoginResp.self) { resp in
            switch resp.result {
            case let .success(res):
                self.token = res
                completion(nil)
                
            case let .failure(err):
                completion(err)
            }
        }
    }
    
    func authSignup(email: String, pass: String, completion: @escaping (Error?) -> Void) {
        AF.request(baseUrl + "/v1/auth/register", method: .post, parameters: [ "email": email, "password": pass ] as Parameters, encoding: JSONEncoding.default).responseDecodable(of: LoginResp.self) { resp in
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
        AF.request(baseUrl + "/v1/auth/refresh", method: .post, parameters: [ "refreshToken": token?.refreshToken ] as Parameters, encoding: JSONEncoding.default).responseDecodable(of: LoginResp.self) { resp in
            switch resp.result {
            case let .success(res):
                self.token = res
                completion(nil)
                
            case let .failure(err):
                completion(err)
            }
        }
    }

    func users(completion: @escaping (Result<[UserModel], AFError>) -> Void) {
        AF.request(baseUrl + "/v1/user", method: .get, parameters: [ "limit": 5, "offset": 0 ] as Parameters, headers: [ "Authorization": "Bearer " + (token?.accessToken ?? "") ]).responseDecodable(of: [UserModel].self) { resp in
            completion(resp.result)
        }
    }
    
    struct FeedbackResp: Decodable {
        let isMutual: Bool
    }

    func feedback(_ like: Bool, userId: String, completion: @escaping (Result<FeedbackResp, AFError>) -> Void) {
        AF.request(baseUrl + "/v1/user/\(userId)/\(like ? "like" : "dislike")", method: .post, headers: [ "Authorization": "Bearer " + (token?.accessToken ?? "") ]).responseDecodable(of: FeedbackResp.self) { resp in
            completion(resp.result)
        }
    }
    
    func chats(completion: @escaping (Result<[ChatModel], AFError>) -> Void) {
        AF.request(baseUrl + "/v1/chat", method: .get, headers: [ "Authorization": "Bearer " + (token?.accessToken ?? "") ]).responseDecodable(of: [ChatModel].self) { resp in
            completion(resp.result)
        }
    }
    
    func messages(chatId: String, completion: @escaping (Result<[MessageModel], AFError>) -> Void) {
        AF.request(baseUrl + "/v1/chat/\(chatId)/message", method: .get, parameters: [ "limit": 5, "offset": 0 ] as Parameters, headers: [ "Authorization": "Bearer " + (token?.accessToken ?? "") ]).responseDecodable(of: [MessageModel].self) { resp in
            completion(resp.result)
        }
    }
}

struct ChatModel: Codable {
    let chat: ChatInfo
    
   
    
    let lastMessage: MessageModel
}

struct ChatInfo: Codable {
    let id: String
    let title: String
    let avatar: URL?
}

struct MessageModel: Codable {
    let id: String
    
    let text: String
    let createdAt: DateInRegion
    let user: UserModel
    
}

struct UserModel: Codable {
    let userId: String
    let name: String
    let aboutMyself: String
    let avatar: URL?
    let topics: [TopicModel]
}

struct TopicModel: Codable {
    let title: String
    let id: String
}
