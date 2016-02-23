//
//  Post.swift
//  Timeline
//
//  Created by Gibson Smiley on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

struct Post: Equatable {
    
    var imageEndPoint: String
    var caption: String?
    var username: String
    var likes: [Like]
    var comments: [Comment]
    var identifier: String?
    
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