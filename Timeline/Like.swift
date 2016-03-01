//
//  Like.swift
//  Timeline
//
//  Created by Gibson Smiley on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

struct Like: Equatable, FirebaseType {
    
    private let kUsername = "username"
    private let kPost = "post"
    
    var username: String
    var postIdentifier: String
    var identifier: String?
    var endpoint: String {
        return "/posts/\(self.postIdentifier)/likes"
    }
    var jsonValue: [String: AnyObject] {
        return [kUsername: username, kPost: postIdentifier]
    }
    
    init?(json: [String: AnyObject], identifier: String) {
        guard let postIdentifier = json[kPost] as? String,
            let username = json[kUsername] as? String else { return nil }
        
        self.postIdentifier = postIdentifier
        self.username = username
    }
    
    init(username: String, postIdentifier: String, identifier: String? = nil) {
        self.username = username
        self.postIdentifier = postIdentifier
        self.identifier = identifier
    }
}
func ==(lhs: Like, rhs: Like) -> Bool {
    return lhs.username == rhs.username && lhs.identifier == rhs.identifier
}