//
//  PostViewCell.swift
//  RedditTheGrint
//
//  Created by Armando Brito on 16/5/23.
//

import UIKit
import SDWebImage

class PostViewCell: UITableViewCell {

    @IBOutlet weak private var coreContentView: UIView!
    @IBOutlet weak private var postImage: UIImageView!
    @IBOutlet weak private var postSubreddit: UILabel!
    @IBOutlet weak private var postAuthorAndDate: UILabel!
    @IBOutlet weak private var postTitle: UILabel!
    @IBOutlet weak private var postComments: UILabel!
    @IBOutlet weak private var imageHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        coreContentView.layer.cornerRadius = 10.0
        postImage.layer.masksToBounds = true
        postImage.layer.cornerRadius = 10.0
        postImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {

    }

    func config(_ post: Post) {
        let data = post.data
        let formatedDate = formatDate(data.created)
        imageHeightConstraint.constant = 120
        if !data.thumbnail.isValidURL {
            imageHeightConstraint.constant = 0
        }
        postImage.sd_setImage(with: URL(string: data.thumbnail), placeholderImage: UIImage(systemName: "photo.artframe"))
        postSubreddit.text = data.subredditNamePrefixed
        postAuthorAndDate.text = "Postd by \(data.author) on \(formatedDate)"
        postTitle.text = data.title
        postComments.text = "\(data.numComments)"
    }

    private func formatDate(_ intDate: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(intDate))
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }

}