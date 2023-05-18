//
//  PostsViewModel.swift
//  RedditTheGrint
//
//  Created by Armando Brito on 16/5/23.
//

import Foundation

extension PostsViewController {

    // MARK: - View model

    class ViewModel {
        
        // MARK: Properties

        let webService: RedditAPIService = WebService()
        var persistence: PersistenceService = Persistence()
        var update: ((ViewModel) -> Void)?
        var posts = [Post]()
        var after: String?

        // MARK: Behavior

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
                self.persistence.after = self.after
                self.persistence.posts = self.posts
            }
        }

        func restoreState() -> Bool {
            guard let after = persistence.after,
               let posts = persistence.posts
            else {
                return false
            }
            self.after = after
            self.posts = posts
            return true
        }
    }

}
