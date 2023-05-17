//
//  PostsResponse.swift
//  RedditTheGrint
//
//  Created by Armando Brito on 17/5/23.
//

import Foundation

// MARK: - PostsResponse
struct PostsResponse: Codable {
    let kind: String
    let data: PostsResponseData
}

// MARK: - PostsResponseData
struct PostsResponseData: Codable {
    let after: String?
    let dist: Int
    let modhash: String
    let geoFilter: String
    let children: [Post]
    let before: String?

    enum CodingKeys: String, CodingKey {
        case after, dist
        case modhash
        case geoFilter = "geo_filter"
        case children
        case before
    }
}

// MARK: - Post
struct Post: Codable {
    let kind: Kind
    let data: PostData
}

// MARK: - PostData
struct PostData: Codable {
    let authorFullname: String
    let title: String
    let name: String
    let score: Int
    let thumbnail: String
    let created: Int
    let id: String
    let author: String
    let numComments: Int
    let url: String
    let subreddit: String
    let subredditNamePrefixed: String

    enum CodingKeys: String, CodingKey {
        case authorFullname = "author_fullname"
        case title
        case name
        case score
        case thumbnail
        case created
        case id
        case author
        case numComments = "num_comments"
        case url
        case subreddit
        case subredditNamePrefixed = "subreddit_name_prefixed"
    }
}

enum Kind: String, Codable {
    case t3 = "t3"
}
