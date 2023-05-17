//
//  RedditAPIService.swift
//  RedditTheGrint
//
//  Created by Armando Brito on 17/5/23.
//

import Foundation
import Alamofire

protocol RedditAPIService {
    func fetchPosts(_ completion: @escaping (PostsResponse?) -> Void)
}

class WebService: RedditAPIService {

    func fetchPosts(_ completion: @escaping (PostsResponse?) -> Void) {
        AF.request(
            "https://www.reddit.com/r/all/top/.json",
            method: .get,
            headers: nil,
            interceptor: nil,
            requestModifier: nil
        ).response { responseData in
            switch responseData.result {
                case .failure(let error):
                    print(error)
                    completion(nil)
                case .success(let data):
                    guard let data else {
                        completion(nil)
                        return
                    }
                    do {
                        let postsResponse = try JSONDecoder().decode(PostsResponse.self, from: data)
                        completion(postsResponse)
                    } catch(let error) {
                        print("Could not serialize. \(error)")
                        completion(nil)
                    }
            }
        }
    }

}
