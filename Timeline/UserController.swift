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
        FirebaseController.dataAtEndpoint("users/\(identifier)") { (data) -> Void in
            if let data = data as? [String: AnyObject] {
                let user = User(json: data, identifier: identifier)
                completion(user: user)
            } else {
                completion(user: nil)
            }
        }
    }
    
    static func fetchAllUsers(completion: (users: [User]) -> Void) {
        FirebaseController.dataAtEndpoint("users") { (data) -> Void in
            if let userDictionaries = data as? [String: AnyObject] {
                let users = userDictionaries.flatMap({User(json: $0.1 as! [String: AnyObject], identifier: $0.0)})
                completion(users: users)
            } else {
                completion(users: [])
            }
        }
    }
    
    static func followUser(user: User, completion: (success: Bool) -> Void) {
        FirebaseController.base.childByAppendingPath("users/\(currentUser.identifier)/follows/\(user.identifier!)").setValue(true)
        completion(success: true)
    }
    
    static func unfollowUser(user: User, completion: (success: Bool) -> Void) {
        FirebaseController.base.childByAppendingPath("users/\(currentUser.identifier)/follows/\(user.identifier)").removeValue()
        completion(success: true)
    }
    
    static func userFollowsUser(user1: User, user2: User, completion: (follows: Bool) -> Void) {
        FirebaseController.dataAtEndpoint("users/\(user1.identifier)/follows/\(user2.identifier)") { (data) -> Void in
            if let _ = data {
                completion(follows: true)
            } else {
                completion(follows: false)
            }
        }
    }
    
    static func followedByUser(user: User, completion: (followed: [User]?) -> Void) {
        FirebaseController.dataAtEndpoint("users/\(user.identifier)/follows") { (data) -> Void in
            if let json = data as? [String: AnyObject] {
                var users: [User] = []
                for userJson in json {
                    userForIdentifier(userJson.0, completion: { (user) -> Void in
                        if let user = user {
                            users.append(user)
                            completion(followed: users)
                        }
                    })
                }
            } else {
                completion(followed: [])
            }
        }
    }
    
    static func authenticateUser(email: String, password: String, completion: (sucess: Bool, user: User?) -> Void) {
            FirebaseController.base.authUser(email, password: password, withCompletionBlock: { (error, authData) -> Void in
                if let error = error {
                    print("\(error.localizedDescription)")
                    completion(sucess: false, user: nil)
                } else {
                    completion(sucess: true, user: UserController.currentUser)
                }
            })
    }
    
    static func createUser(email: String, username: String, password: String, bio: String?, url: String?, completion: (sucess: Bool, user: User?) -> Void) {
        FirebaseController.base.createUser(email, password: password) { (error, results) -> Void in
            if let error = error {
                print("\(error.localizedDescription)")
            } else {
                if let uid = results["uid"] as? String {
                    var user = User(username: username, bio: bio, url: url, identifier: uid)
                    user.save()
                }
            }
        }
    }
    
    static func updateUser(user: User, username: String, bio: String?, url: String?, completion: (success: Bool, user: User?) -> Void) {
        var updatedUser = User(username: user.username, bio: bio, url: url, identifier: user.identifier)
            updatedUser.save()
        UserController.userForIdentifier(user.identifier!) { (user) -> Void in
            if let user = user {
                currentUser = user
                completion(success: true, user: user)
            } else {
                completion(success: false, user: user)
            }
        }
    }
    
    static func logOutCurrentUser() {
        FirebaseController.base.unauth()
        UserController.currentUser = nil
    }
    
    static func mockUsers() -> [User] {
        let user1 = User(username: "gibson", bio: "iOS Developer and all around terrible guy", url: "https://gibsonsmiley.com", identifier: "53057")
        let user2 = User(username: "brock", bio: "hi, i'm brock", url: "brock.rock", identifier: "5720872")
        let user3 = User(username: "james", bio: "first things first; no", url: "devmtn.com", identifier: "5728264")
        
        let mockArray = [user1, user2, user3]
        return mockArray
    }
}






