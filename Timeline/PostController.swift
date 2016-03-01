//
//  PostController.swift
//  Timeline
//
//  Created by Gibson Smiley on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import UIKit

class PostController {
    
    static func fetchTimelineForUser(user: User, completion: (post: [Post]?) -> Void) {
        UserController.followedByUser(user) { (followed) -> Void in
            var allPosts: [Post] = []
            let dispatchGroup = dispatch_group_create()
            
            dispatch_group_enter(dispatchGroup)
            postsForUser(UserController.currentUser, completion: { (posts) -> Void in
                if let posts = posts {
                    allPosts += posts
                }
                dispatch_group_leave(dispatchGroup)
            })
            if let followed = followed {
                for user in followed {
                    dispatch_group_enter(dispatchGroup)
                    postsForUser(user, completion: { (posts) -> Void in
                        if let posts = posts {
                            allPosts += posts
                        }
                        dispatch_group_leave(dispatchGroup)
                    })
                }
            }
            dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), { () -> Void in
                let orderedPosts = orderPosts(allPosts)
                completion(post: orderedPosts)
            })
        }
    }
    
    static func addPost(image: UIImage, caption: String?, completion: (success: Bool, post: Post?) -> Void) {
        ImageController.uploadImage(image) { (identifier) -> Void in
             if let identifier = identifier {
                var post = Post(imageEndPoint: identifier, caption: caption, username: UserController.currentUser.username)
                post.save()
                completion(success: true, post: post)
            } else {
                completion(success: false, post: nil)
            }
        }
    }
    
    static func postFromIdentifier(identifier: String, completion: (post: Post?) -> Void) {
        FirebaseController.dataAtEndpoint("/posts/\(identifier)") { (data) -> Void in
            if let data = data as? [String: AnyObject] {
                let post = Post(json: data, identifier: identifier)
                completion(post: post)
            } else {
                completion(post: nil)
            }
        }
    }
    
    static func postsForUser(user: User, completion: (posts: [Post]?) -> Void) {
        FirebaseController.base.childByAppendingPath("posts").queryOrderedByChild("username").queryEqualToValue(user.username).observeSingleEventOfType(.Value, withBlock: { (snapshot) -> Void in
            if let postDictionaries = snapshot.value as? [String: AnyObject] {
                let posts = postDictionaries.flatMap({Post(json: $0.1 as! [String: AnyObject], identifier: $0.0)})
                let orderedPosts = orderPosts(posts)
                completion(posts: orderedPosts)
            } else {
                completion(posts: nil)
            }
        })
    }
    
    static func deletePost(post: Post) {
        post.delete()
    }
    
    static func addCommentWithTextToPost(text: String, post: Post, completion: (success: Bool, post: Post?) -> Void) {
        if let postIdentifier = post.identifier {
            var comment = Comment(username: UserController.currentUser.username, text: text, postIdentifier: postIdentifier)
            comment.save()
            
            PostController.postFromIdentifier(comment.postIdentifier, completion: { (post) -> Void in
                completion(success: true, post: post)
            })
        }
    }
    
    static func deleteComment(comment: Comment, completion: (success: Bool, post: Post?) -> Void) {
        comment.delete()
        
        PostController.postFromIdentifier(comment.postIdentifier) { (post) -> Void in
            completion(success: true, post: post)
        }
    }
    
    static func addLikeToPost(post: Post, completion: (success: Bool, post: Post?) -> Void) {
        if let postIdentifier = post.identifier {
            var like = Like(username: UserController.currentUser.username, postIdentifier: postIdentifier)
            like.save()
        }
    }
    
    static func deleteLike(like: Like, completion: (success: Bool, post: Post) -> Void) {
        like.delete()
        PostController.postFromIdentifier(like.identifier!) { (post) -> Void in ///** !!! **///
            completion(success: true, post: post!) ///** !!! **///
        }
    }
    
    static func orderPosts(posts: [Post]) -> [Post] {
        return posts.sort({$0.0.identifier > $0.1.identifier})
    }
    
    static func mockPosts() -> [Post] {
        let post1 = Post(imageEndPoint: "K1l4125TYvKMc7rcp5e", caption: nil, username: "gibson", likes: [], comments: [], identifier: "30184")
        let post2 = Post(imageEndPoint: "K1l4125TYvKMc7rcp5e", caption: "OHEMGEE", username: "brock", likes: [], comments: [], identifier: "08562")
        let post3 = Post(imageEndPoint: "K1l4125TYvKMc7rcp5e", caption: "no", username: "james", likes: [], comments: [], identifier: "74012")
        
        let mockArray = [post1, post2, post3]
        return mockArray
    }
}








