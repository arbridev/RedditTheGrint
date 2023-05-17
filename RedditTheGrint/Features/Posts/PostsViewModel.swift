//
//  PostsViewModel.swift
//  RedditTheGrint
//
//  Created by Armando Brito on 16/5/23.
//

import Foundation

extension PostsViewController {

    class ViewModel {
        let webService: RedditAPIService = WebService()
        var update: ((ViewModel) -> Void)?
        var posts = [Post]()

        func fetchPosts() {
            webService.fetchPosts { response in
                guard let response else {
                    self.posts = [Post]()
                    self.update?(self)
                    return
                }
                self.posts = response.data.children
                self.update?(self)
            }
        }
    }

}
