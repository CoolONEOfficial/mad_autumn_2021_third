//
//  NetworkService+topic.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 04.11.2021.
//

import Foundation
import Alamofire

extension NetworkService {
    func topics(completion: @escaping (Result<[TopicModel], AFError>) -> Void) {
        AF.request(baseUrl + "/v1/topic", method: .get, headers: authorizationHeaders).responseDecodable(of: [TopicModel].self) { resp in
            completion(resp.result)
        }
    }
}
