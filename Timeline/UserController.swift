//
//  UserController.swift
//  Timeline
//
//  Created by Gibson Smiley on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class UserController {
    
    private static let kUser = "userKey"
    
    static var currentUser: User! {
        get{
        guard let uid = FirebaseController.base.authData?.uid, let userDictionary = NSUserDefaults.standardUserDefaults().valueForKey(kUser) as? [String: AnyObject] else { return nil }
        return User(json: userDictionary, identifier: uid)
        }
        set {
            if let newValue = newValue {
                NSUserDefaults.standardUserDefaults().setValue(newValue.jsonValue, forKey: kUser)
                NSUserDefaults.standardUserDefaults().synchronize()
            } else {
                NSUserDefaults.standardUserDefaults().removeObjectForKey(kUser)
                NSUserDefaults.standardUserDefaults().synchronize()
            }
        }
    }
    
    static func userForIdentifier(identifier: String, completion: (user: User?) -> Void) {
        FirebaseController.dataAtEndpoint("/posts/\(identifier)") { (data) -> Void in
            if let data = data as? [String: AnyObject] {
                let user = User(json: data, identifier: identifier)
                completion(user: user)
            } else {
                completion(user: nil)
            }
        }
    }
    
    static func fetchAllUsers(completion: (users: [User]) -> Void) {
        FirebaseController.base.childByAppendingPath("users").observeSingleEventOfType(.Value, withBlock: { (snapshot) -> Void in
            if let userDictionaries = snapshot.value as? [String: AnyObject] {
                let users = userDictionaries.flatMap({User(json: $0.1 as! [String: AnyObject], identifier: $0.0)})
                completion(users: users)
            }
        })
    }
    
    static func followUser(user: User, completion: (success: Bool) -> Void) {
        FirebaseController.base.childByAppendingPath("/users/\(currentUser.identifier)/follows/\(user.identifier!)").setValue(true)
        completion(success: true)
    }
    
    static func unfollowUser(user: User, completion: (success: Bool) -> Void) {
        FirebaseController.base.childByAppendingPath("users/\(currentUser.identifier)/follows/\(user.identifier)").removeValue()
        completion(success: true)
    }
    
    static func userFollowsUser(user1: User, user2: User, completion: (follows: Bool) -> Void) {
        
    }
    
    static func followedByUser(user: User, completion: (followed: [User]?) -> Void) {
        
    }
    
    static func authenticateUser(email: String, password: String, completion: (sucess: Bool, user: User?) -> Void) {
        
    }
    
    static func createUser(email: String, username: String, password: String, bio: String?, url: String?, completion: (sucess: Bool, user: User?) -> Void) {
        FirebaseController.base.createUser(email, password: password) { (error, results) -> Void in
            if let error = error {
                print("\(error.localizedDescription)")
            } else {
                let uid = results["uid"]
            }
        }
    }
    
    static func updateUser(user: User, username: String, bio: String?, url: String?, completion: (success: Bool, user: User?) -> Void) {
        
    }
    
    static func logOutCurrentUser() {
        
    }
    
    static func mockUsers() -> [User] {
        let user1 = User(username: "gibson", bio: "iOS Developer and all around terrible guy", url: "https://gibsonsmiley.com", identifier: "53057")
        let user2 = User(username: "brock", bio: "hi, i'm brock", url: "brock.rock", identifier: "5720872")
        let user3 = User(username: "james", bio: "first things first; no", url: "devmtn.com", identifier: "5728264")
        
        let mockArray = [user1, user2, user3]
        return mockArray
    }
}






