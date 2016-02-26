//
//  UserController.swift
//  Timeline
//
//  Created by Gibson Smiley on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class UserController {
    
    static var currentUser: User! {
//        return nil
        return UserController.mockUsers().first!
    }
    
    static let sharedController = UserController()
    
    static func userForIdentifier(identifier: String, completion: (user: User?) -> Void) {
        completion(user: mockUsers().first)
    }
    
    static func fetchAllUsers(completion: (user: [User]) -> Void) {
        completion(user: mockUsers())
    }
    
    static func followUser(user: User, completion: (success: Bool) -> Void) {
        completion(success: true)
    }
    
    static func unfollowUser(user: User, completion: (success: Bool) -> Void) {
        completion(success: true)
    }
    
    static func userFollowsUser(user1: User, user2: User, completion: (follows: Bool) -> Void) {
        completion(follows: true)
    }
    
    static func followedByUser(user: User, completion: (followed: [User]?) -> Void) {
        completion(followed: mockUsers())
    }
    
    static func authenticateUser(email: String, password: String, completion: (sucess: Bool, user: User?) -> Void) {
        completion(sucess: true, user: mockUsers().first)
    }
    
    static func createUser(email: String, username: String, password: String, bio: String?, url: String?, completion: (sucess: Bool, user: User?) -> Void) {
        completion(sucess: true, user: mockUsers().first)
    }
    
    static func updateUser(user: User, username: String, bio: String?, url: String?, completion: (success: Bool, user: User?) -> Void) {
        completion(success: true, user: mockUsers().first)
    }
    
    static func logOutCurrentUser() {
        
    }
    
    static func mockUsers() -> [User] {
        let user1 = User(username: "gibson", bio: nil, url: nil, identifier: "53057")
        let user2 = User(username: "brock", bio: "hi, i'm brock", url: "brock.rock", identifier: "5720872")
        let user3 = User(username: "james", bio: "first things first; no", url: "devmtn.com", identifier: "5728264")
        
        let mockArray = [user1, user2, user3]
        return mockArray
    }
}






