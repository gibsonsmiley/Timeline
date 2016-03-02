//
//  LoginSignupViewController.swift
//  Timeline
//
//  Created by Gibson Smiley on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class LoginSignupViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailtextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var loginSignupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViewBasedOnMode()
    }
    
    enum ViewMode {
        case Login
        case Signup
        case Edit
    }
    
    var mode: ViewMode = .Signup
    var fieldsAreValid: Bool {
        get {
            switch mode {
            case .Login: return (emailtextField.text!.isEmpty || passwordTextField.text!.isEmpty)
            case .Signup: return (emailtextField.text!.isEmpty || passwordTextField.text!.isEmpty || usernameTextField.text!.isEmpty)
            case .Edit: return (usernameTextField.text!.isEmpty)
            }
//            if mode == .Login {
//                if emailtextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true {
//                    return false
//                } else {
//                    return true
//                }
//            } else if mode == .Signup {
//                if emailtextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true || usernameTextField.text?.isEmpty == true {
//                    return false
//                } else {
//                    return true
//                }
//            } else if mode == .Edit {
//                if usernameTextField.text?.isEmpty == true {
//                    return false
//                } else {
//                    return true
//                }
//            }
        }
    }
    
    var user: User?
    
    func updateWithUser(user: User){
        self.user = user
        mode = .Edit
    }

    func updateViewBasedOnMode() {
        switch mode {
        case .Login:
            bioTextField.hidden = true
            websiteTextField.hidden = true
            usernameTextField.hidden = true
            loginSignupButton.setTitle("Log In", forState: .Normal)
        case .Signup:
            loginSignupButton.setTitle("Sign Up", forState: .Normal)
        case .Edit:
            if let user = self.user {
            usernameTextField.text = user.username
            bioTextField.text = user.bio
            websiteTextField.text = user.url
            }
            loginSignupButton.setTitle("Save Changes", forState: .Normal)
            emailtextField.hidden = true
            passwordTextField.hidden = true
        }
    }
    
    @IBAction func actionButtonTapped(sender: AnyObject) {
        if fieldsAreValid {
            switch mode {
            case .Login:
                UserController.authenticateUser(self.emailtextField.text!, password: passwordTextField.text!, completion: { (success, user) -> Void in
                    if success, let _ = user {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                        self.presentValidationAlertWithTitle("Unable to Log In", message: "Please check your information and try again.")
                    }
                })
            case .Signup:
                UserController.createUser(emailtextField.text!, username: usernameTextField.text!, password: passwordTextField.text!, bio: bioTextField.text, url: websiteTextField.text, completion: { (success, user) -> Void in
                    if success, let _ = user {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                        self.presentValidationAlertWithTitle("Unable to Signup", message: "Please check your information and try again.")
                    }
                })
            case .Edit:
                UserController.updateUser(self.user!, username: self.usernameTextField.text!, bio: self.bioTextField.text, url: self.websiteTextField.text, completion: { (success, user) -> Void in
                    
                    if success {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                        self.presentValidationAlertWithTitle("Unable to Update User", message: "Please check your information and try again.")
                    }
                })
            }
        } else {
            presentValidationAlertWithTitle("Missing Information", message: "Please check your information and try again.")
        }
        
    }
    
    func presentValidationAlertWithTitle(title: String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
