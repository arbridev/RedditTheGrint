//
//  PostViewCell.swift
//  RedditTheGrint
//
//  Created by Armando Brito on 16/5/23.
//

import UIKit

class PostViewCell: UITableViewCell {

    @IBOutlet weak private var coreContentView: UIView!
    @IBOutlet weak private var postImage: UIImageView!
    @IBOutlet weak private var postUser: UILabel!
    @IBOutlet weak private var postDate: UILabel!
    @IBOutlet weak private var postTitle: UILabel!
    @IBOutlet weak private var postComments: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        coreContentView.layer.cornerRadius = 10.0
        postImage.layer.masksToBounds = true
        postImage.layer.cornerRadius = 10.0
        postImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {

    }

}
