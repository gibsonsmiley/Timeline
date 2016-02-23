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
        completion(post: mockPosts())
    }
    
    static func addPost(image: UIImage, caption: String?, completion: (success: Bool, post: Post?) -> Void) {
        completion(success: true, post: mockPosts().first)
    }
    
    static func postFromIdentifier(identifier: String, completion: (post: Post?) -> Void) {
        completion(post: mockPosts().first)
    }
    
    static func postsForUser(user: User, completion: (posts: [Post]?) -> Void) {
        completion(posts: mockPosts())
    }
    
    static func deletePost(post: Post) {
        
    }
    
    static func addCommentWithTextToPost(string: String, post: Post, completion: (success: Bool, post: Post?) -> Void) {
        completion(success: true, post: mockPosts().first)
    }
    
    static func deleteComment(comment: Comment, completion: (success: Bool, post: Post?) -> Void) {
        completion(success: true, post: mockPosts().first)
        }
    
    static func addLikeToPost(post: Post, completion: (success: Bool, post: Post?) -> Void) {
        completion(success: true, post: mockPosts().first)
    }
    
    static func deleteLike(like: Like, completion: (success: Bool, post: Post) -> Void) {
        completion(success: true, post: mockPosts().first!)
    }
    
    static func orderPosts(posts: [Post] -> [Post]) {
        
    }
    
    static func mockPosts() -> [Post] {
        let post1 = Post(imageEndPoint: "K1l4125TYvKMc7rcp5e", caption: nil, username: "gibson", likes: [], comments: [], identifier: "30184")
        let post2 = Post(imageEndPoint: "K1l4125TYvKMc7rcp5e", caption: "OHEMGEE", username: "brock", likes: [], comments: [], identifier: "08562")
        let post3 = Post(imageEndPoint: "K1l4125TYvKMc7rcp5e", caption: "no", username: "james", likes: [], comments: [], identifier: "74012")
        
        let mockArray = [post1, post2, post3]
        return mockArray
    }
}








