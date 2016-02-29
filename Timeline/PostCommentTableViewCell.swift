//
//  PostCommentTableViewCell.swift
//  Timeline
//
//  Created by Gibson Smiley on 2/29/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class PostCommentTableViewCell: UITableViewCell {

    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commenterUsernameButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateWithComment(comment: Comment) {
        commentLabel.text = comment.text
        commenterUsernameButton.setTitle("\(comment.username)", forState: .Normal)
    }
}
