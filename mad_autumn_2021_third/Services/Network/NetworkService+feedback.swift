//
//  NetworkService+feedback.swift
//  mad_autumn_2021_third
//
//  Created by Nickolay Truhin on 01.11.2021.
//

import Foundation
import Alamofire

extension NetworkService {
    struct FeedbackResp: Decodable {
        let isMutual: Bool
    }

    func feedback(_ like: Bool, userId: String, completion: @escaping (Result<FeedbackResp, AFError>) -> Void) {
        AF.request(baseUrl + "/v1/user/\(userId)/\(like ? "like" : "dislike")", method: .post, headers: authorizationHeaders).responseDecodable(of: FeedbackResp.self) { resp in
            completion(resp.result)
        }
    }
}
