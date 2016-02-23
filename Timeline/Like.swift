//
//  Like.swift
//  Timeline
//
//  Created by Gibson Smiley on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

struct Like: Equatable {
    
    var username: String
    var postIdentifier: String
    var identifier: String?
    
    init(username: String, postIdentifier: String, identifier: String? = nil) {
        self.username = username
        self.postIdentifier = postIdentifier
        self.identifier = identifier
    }
}
func ==(lhs: Like, rhs: Like) -> Bool {
    return lhs.username == rhs.username && lhs.identifier == rhs.identifier
}