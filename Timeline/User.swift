//
//  User.swift
//  Timeline
//
//  Created by Gibson Smiley on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

struct User: Equatable {
    
    var username: String
    var bio: String?
    var url: String?
    var identifier: String?
    
    init(username: String, bio: String? = nil, url: String? = nil, identifier: String? = nil) {
        self.username = username
        self.bio = bio
        self.url = url
        self.identifier = identifier
    }
}
func ==(lhs: User, rhs: User) -> Bool {
    return lhs.username == rhs.username && lhs.identifier == rhs.identifier
}