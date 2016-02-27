//
//  ProfileViewController.swift
//  Timeline
//
//  Created by Gibson Smiley on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit
import SafariServices

class ProfileViewController: UIViewController, UICollectionViewDataSource, ProfileHeaderCollectionReusableViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var user: User?
    var userPosts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.user == nil {
            self.user = UserController.currentUser
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updatebasedOnUser() {
        self.title = user?.username
        PostController.postsForUser(user!) { (posts) -> Void in
            if let posts = posts {
                self.userPosts = posts
            } else {
                self.userPosts = []
            }
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPosts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("imageCell", forIndexPath: indexPath) as! ImageCollectionViewCell
        let post = userPosts[indexPath.row]
        cell.updateWithImageIdentifier(post.imageEndPoint)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView", forIndexPath: indexPath) as! ProfileHeaderCollectionReusableView
        header.updateWithUser(self.user!)
        header.delegate = self
        return header
    }
    
    func userTappedURLButton() {
        if let url = NSURL(string: user!.url!) {
            let safariController = SFSafariViewController(URL: url)
            presentViewController(safariController, animated: true, completion: nil)
        }
    }
    
    func userTappedFollowActionButton() {
        guard let user = user else { return }
        if user == UserController.currentUser {
            UserController.logOutCurrentUser()
        } else {
            UserController.userFollowsUser(UserController.currentUser, user2: user, completion: { (follows) -> Void in
                if follows {
                    UserController.unfollowUser(user, completion: { (success) -> Void in
                        return true
                    })
                } else {
                    UserController.followUser(user, completion: { (success) -> Void in
                        return true
                    })
                }
            })
        }
    }
    

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toEditProfile" {
            let destinationViewController = segue.destinationViewController as? LoginSignupViewController
            
            _ = destinationViewController?.view
            
            destinationViewController?.updateWithUser(user!)
        } else if segue.identifier == "profileToDetail" {
            if let cell = sender as? UICollectionViewCell, let indexPath = collectionView.indexPathForCell(cell) {
                let post = userPosts[indexPath.row]
                
                let destinationViewController = segue.destinationViewController as? PostDetailTableViewController
                destinationViewController?.post = post
            }
        }
    }
}
