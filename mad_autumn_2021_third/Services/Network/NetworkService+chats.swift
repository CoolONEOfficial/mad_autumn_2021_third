//
//  NetworkService+chats.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 01.11.2021.
//

import Foundation
import Alamofire

extension NetworkService {
    func chats(completion: @escaping (Result<[ChatModel], AFError>) -> Void) {
        AF.request(baseUrl + "/v1/chat", method: .get, headers: authorizationHeaders).responseDecodable(of: [ChatModel].self) { resp in
            completion(resp.result)
        }
    }
}
