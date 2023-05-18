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
        selectionStyle = .none
        coreContentView.layer.cornerRadius = 10.0
        postImage.layer.masksToBounds = true
        postImage.layer.cornerRadius = 10.0
        postImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            UIView.animate(
                withDuration: 0.5,
                delay: 0.0,
                usingSpringWithDamping: 0.5,
                initialSpringVelocity: 0.2
            ) { [weak self] in
                self?.coreContentView.transform = CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5)
                UIView.animate(
                    withDuration: 0.5,
                    delay: 0.0,
                    usingSpringWithDamping: 0.8,
                    initialSpringVelocity: 0.2
                ) { [weak self] in
                    self?.coreContentView.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
                }
            }
        }
    }

    func config(_ post: Post) {
        let data = post.data
        let placeholderImage = UIImage(systemName: "photo.artframe")
        placeholderImage?.withRenderingMode(.alwaysTemplate)
        let formatedDate = formatDate(data.created)
        imageHeightConstraint.constant = 120
        if !data.thumbnail.isValidURL {
            imageHeightConstraint.constant = 0
        }
        postImage.tintColor = .systemOrange
        postImage.sd_setImage(with: URL(string: data.thumbnail), placeholderImage: placeholderImage)
        postSubreddit.text = data.subredditNamePrefixed
        postAuthorAndDate.text = "Posted by \(data.author) on \(formatedDate)"
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
