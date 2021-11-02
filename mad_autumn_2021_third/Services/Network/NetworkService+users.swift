//
//  NetworkService+users.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 01.11.2021.
//

import Foundation
import Alamofire

extension NetworkService {
    func users(offset: Int, completion: @escaping (Result<[UserModel], AFError>) -> Void) {
        AF.request(baseUrl + "/v1/user", method: .get, parameters: [ "limit": 10, "offset": offset ] as Parameters, headers: authorizationHeaders).responseDecodable(of: [UserModel].self) { resp in
            completion(resp.result)
        }
    }
}
