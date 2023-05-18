//
//  PostLandscapeViewCell.swift
//  RedditTheGrint
//
//  Created by Armando Brito on 18/5/23.
//

import UIKit

class PostLandscapeViewCell: PostViewCell {

    override func config(_ post: Post) {
        let data = post.data
        let placeholderImage = UIImage(systemName: "photo.artframe")
        placeholderImage?.withRenderingMode(.alwaysTemplate)
        let formatedDate = formatDate(data.created)
        postImage.tintColor = .systemOrange
        postImage.sd_setImage(with: URL(string: data.thumbnail), placeholderImage: placeholderImage)
        postSubreddit.text = data.subredditNamePrefixed
        postAuthorAndDate.text = "Posted by \(data.author) on \(formatedDate)"
        postTitle.text = data.title
        postComments.text = "\(data.numComments)"
    }
    
}
