//
//  ProfileHeaderCollectionReusableView.swift
//  Timeline
//
//  Created by Gibson Smiley on 2/26/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

protocol ProfileHeaderCollectionReusableViewDelegate {
    
    func userTappedFollowActionButton()
    func userTappedURLButton()
}

class ProfileHeaderCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var urlButton: UIButton!
    @IBOutlet weak var followButton: UIButton!
    
    var delegate: ProfileHeaderCollectionReusableViewDelegate?
    
    func updateWithUser(user: User) {
        
        if let bio = user.bio {
            bioLabel.text = user.bio
        } else {
            bioLabel.hidden = true
        }
        
        if let url = user.url {
            urlButton.setTitle("URL", forState: .Normal)
        } else {
            urlButton.hidden = true
        }
        
        if user == UserController.currentUser {
            followButton.setTitle("Logout", forState: .Normal)
        } else {
            UserController.userFollowsUser(UserController.currentUser, user2: user, completion: { (follows) -> Void in
                if follows {
                    self.followButton.setTitle("Unfollow", forState: .Normal)
                } else {
                    self.followButton.setTitle("Follow", forState: .Normal)
                }
            })
        }
    }
    
    @IBAction func followActionButton(sender: AnyObject) {
        delegate?.userTappedFollowActionButton()
    }
    
    @IBAction func urlButtonTapped(sender: AnyObject) {
        delegate?.userTappedURLButton()
    }
    
}