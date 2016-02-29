//
//  PostTableViewCell.swift
//  Timeline
//
//  Created by Gibson Smiley on 2/29/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var imagePostView: UIImageView!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var usernameButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateWithPost(post: Post) {
        imagePostView.image = nil
        
        likesLabel.text = "\(post.likes.count) likes"
        commentsLabel.text = "\(post.comments.count) comments"
        usernameButton.setTitle("\(post.username)", forState: .Normal)
        
        ImageController.imageForIdentifier(post.imageEndPoint) { (image) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.imagePostView.image = image
            })
        }
    }
}
