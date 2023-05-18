//
//  PersistenceService.swift
//  RedditTheGrint
//
//  Created by Armando Brito on 18/5/23.
//

import Foundation

protocol PersistenceService {
    var after: String? { get set }
    var posts: [Post]? { get set }
}

class Persistence: PersistenceService {

    enum PersistenceKey: String {
        case after, posts
    }

    let userDefaults: UserDefaults

    var after: String? {
        get {
            userDefaults.string(forKey: PersistenceKey.after.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: PersistenceKey.after.rawValue)
        }
    }

    var posts: [Post]? {
        get {
            if let data = userDefaults.data(forKey: PersistenceKey.posts.rawValue) {
                return try? JSONDecoder().decode([Post]?.self, from: data)
            } else {
                return nil
            }
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            userDefaults.set(data, forKey: PersistenceKey.posts.rawValue)
        }
    }

    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
}
