//
//  PostTableViewCell.swift
//  viper-demo-post
//
//  Created by idris yıldız on 1.09.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    public static let reuseIdentifier = "PostTableViewCell"
    
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!

    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var sharedCount: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var seenCount: UILabel!
    @IBOutlet weak var commentCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func config(item:PostModel)
    {
        content.text = item.des
        userName.text = item.ownerUser.name
        nickName.text = item.ownerUser.nickName
        
        sharedCount.text = "\(item.sharedCount!)"
        likeCount.text = "\(item.likedCount!)"
        seenCount.text = "\(item.seenCount!)"
        commentCount.text = "\(item.commentCount!)"
        
        userImage.image = UIImage(named:item.ownerUser.photoUrl)
        contentImage.image = UIImage(named:item.photoUrl)
        
        contentImage.image = item.photo
    }
}
