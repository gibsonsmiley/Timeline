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
    }
    
    var mode: ViewMode = .Signup
    var fieldsAreValid: Bool {
        get {
            if mode == .Login {
                if emailtextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true {
                    return false
                } else {
                    return true
                }
            } else {
                if emailtextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true || usernameTextField.text?.isEmpty == true {
                    return false
                } else {
                    return true
                }
            }
        }
    }

    func updateViewBasedOnMode() {
        switch mode {
        case .Login:
            bioTextField.hidden = true
            websiteTextField.hidden = true
            usernameTextField.hidden = true
            loginSignupButton.titleLabel?.text = "Log In"
        case .Signup:
            loginSignupButton.titleLabel?.text = "Sign Up"
        }
    }
    
    @IBAction func actionButtonTapped(sender: AnyObject) {
        if fieldsAreValid != false {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            createAlert("All fields are required to sign up", success: false)
        }
    }
    func createAlert(alertMessage: String, success: Bool) {
        var titleString = ""
        if success == true {
            titleString = "Success"
        } else {
            titleString = "Error"
        }
        
        let alertController = UIAlertController(title: titleString, message: alertMessage, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(okAction)
        
        presentViewController(alertController, animated: true, completion: nil)
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
