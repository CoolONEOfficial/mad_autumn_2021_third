//
//  NetworkService+messages.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 01.11.2021.
//

import Foundation
import Alamofire

extension NetworkService {
    func messages(chatId: String, completion: @escaping (Result<[MessageModel], AFError>) -> Void) {
        AF.request(baseUrl + "/v1/chat/\(chatId)/message", method: .get, parameters: [ "limit": 5, "offset": 0 ] as Parameters, headers: authorizationHeaders).responseDecodable(of: [MessageModel].self) { resp in
            completion(resp.result)
        }
    }
}
