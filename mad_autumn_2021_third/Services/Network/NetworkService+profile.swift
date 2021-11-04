//
//  NetworkService+profile.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 04.11.2021.
//

import Foundation
import SwiftyJSON
import Alamofire

extension NetworkService {
    func profile(completion: @escaping (Result<UserModel, AFError>) -> Void) {
        if let profile = self.profile {
            completion(.success(profile))
        } else {
            AF.request(baseUrl + "/v1/profile", method: .get, headers: authorizationHeaders).responseDecodable(of: UserModel.self) { resp in
                self.profile = try? resp.result.get()
                completion(resp.result)
            }
        }
    }

    func profile(profile: UserModel, completion: @escaping (Result<UserModel, AFError>) -> Void) {

        AF.request(baseUrl + "/v1/profile", method: .patch, parameters: try? JSON(data: JSONEncoder().encode(profile)).dictionaryObject, encoding: JSONEncoding.default, headers: authorizationHeaders).responseDecodable(of: UserModel.self) { resp in
            completion(resp.result)
        }
    
    }

    func profileAvatar(avatar: Data, completion: @escaping (Bool) -> Void) {
        AF.upload(multipartFormData: { test in
            test.append(avatar, withName: "avatar", fileName: "avatar.jpg", mimeType: "image/jpeg")
        }, to: baseUrl + "/v1/profile/avatar", method: .post, headers: authorizationHeaders).response { resp in
            completion(resp.response?.statusCode == 204)
        }
    }
}
