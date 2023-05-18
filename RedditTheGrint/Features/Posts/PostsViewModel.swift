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
        var after: String?

        func fetchPosts() {
            webService.fetchPosts(after: after) { response in
                guard let response else {
                    self.update?(self)
                    return
                }
                self.after = response.data.after
                var temp = response.data.children
                temp.append(contentsOf: self.posts)
                self.posts = temp
                self.update?(self)
            }
        }
    }

}
