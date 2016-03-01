//
//  Post.swift
//  Timeline
//
//  Created by Gibson Smiley on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

struct Post: Equatable, FirebaseType {
    
    private let kUsername = "username"
    private let kImageEndPoint = "imageEndPoint"
    private let kCaption = "caption"
    private let kComments = "commets"
    private let kLikes = "likes"
    
    var imageEndPoint: String
    var caption: String?
    var username: String
    var likes: [Like]
    var comments: [Comment]
    var identifier: String?
    var endpoint: String {
        return "/posts"
    }
    var jsonValue: [String: AnyObject] {
        var json: [String: AnyObject] = [kUsername: username, kImageEndPoint: imageEndPoint, kComments: self.comments.map({$0.jsonValue}), kLikes: self.likes.map({$0.jsonValue})]
        
        if let caption = caption {
            json.updateValue(caption, forKey: kCaption)
        }
        return json
    }
    
    init?(json: [String : AnyObject], identifier: String) {
        guard let imageEndPoint = json[kImageEndPoint] as? String,
            let username = json[kUsername] as? String else { return nil }
        
        self.imageEndPoint = imageEndPoint
        self.username = username
        self.caption = json[kCaption] as? String
        self.identifier = identifier
        
        if let commentDictionaries = json[kComments] as? [String: AnyObject] {
            self.comments = commentDictionaries.flatMap({Comment(json: $0.1 as! [String: AnyObject], identifier: $0.0)})
        } else {
            self.comments = []
        }
        
        if let likesDictionaries = json[kLikes] as? [String: AnyObject] {
            self.likes = likesDictionaries.flatMap({Like(json: $0.1 as! [String: AnyObject], identifier: $0.0)})
        } else {
            self.likes = []
        }
    }
    
    init(imageEndPoint: String, caption: String? = nil, username: String, likes: [Like] = [], comments: [Comment] = [], identifier: String? = nil) {
        self.imageEndPoint = imageEndPoint
        self.caption = caption
        self.username = username
        self.likes = likes
        self.comments = comments
        self.identifier = identifier
    }
}
func ==(lhs: Post, rhs: Post) -> Bool {
    return lhs.username == rhs.username && lhs.identifier == rhs.identifier
}