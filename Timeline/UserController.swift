//
//  UserController.swift
//  Timeline
//
//  Created by Gibson Smiley on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class UserController {
    
    var currentUser: User! = nil
    
    static let sharedController = UserController()
    
    static func userForIdentifier(identifier: String, completion: (user: User?) -> Void) {
        
    }
    
    static func fetchAllUsers(completion: (user: [User]) -> Void) {
        
    }
    
    static func followUser(user: User, completion: (success: Bool) -> Void) {
        
    }
    
    static func unfollowUser(user: User, completion: (success: Bool) -> Void) {
        
    }
    
    static func userFollowsUser(user: User, user: User, completion: ()) {
        
    }
    
    static func followedByUser() {
        
    }
    
    static func authenticateUser() {
        
    }
    
    static func createUser() {
        
    }
    
    static func updateUser() {
        
    }
    
    static func logOutCurrentUser() {
        
    }
}