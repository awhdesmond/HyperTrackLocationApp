//
//  ViewController.swift
//  locationApp
//
//  Created by Ang Wei Hao Desmond on 23/9/17.
//  Copyright © 2017 desmond.ang.a0093896H. All rights reserved.
//

import UIKit
import Firebase
import HyperTrack

class LoginViewController: UIViewController {

    var handle: AuthStateDidChangeListenerHandle?
    var firebaseDB: DatabaseReference!

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBAction func loginButtonPressed(_ sender: Any) {
        // Get User details, if specified
        guard let email = emailTextField.text, email != "" else {
            showAlert(message: "Please enter your email")
            return
        }

        guard let password = passwordTextField.text, password != "" else {
            showAlert(message: "Please enter your password")
            return
        }

        AuthController.loginUser(email: email, password: password, successHandler: { (email, phoneNumber) in
            self.loginToHyperTrack(userName: email, phoneNumber: phoneNumber, lookupID: phoneNumber)
            self.performSegue(withIdentifier: "segueToTabViewController", sender: self)
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    @IBAction func signupButtonPressed(_ sender: Any) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseDB = Database.database().reference()

        hideKeyboardWhenTappedAround()
        emailTextField.text = "lhlhyong@gmail.com"
        passwordTextField.text = "password"
        
    }

    func viewWillAppear() {
        print("View will appear")
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in }
    }

    func viewWillDisappear() {
        print("View will disappear")
        Auth.auth().removeStateDidChangeListener(handle!)
    }
}

// HyperTracker Delegate
extension LoginViewController {

    func loginToHyperTrack(userName: String, phoneNumber: String, lookupID: String) {
        /**
         * Get or Create a User for given lookupId on HyperTrack Server here to
         * login your user & configure HyperTrack SDK with this generated
         * HyperTrack UserId.
         * OR
         * Implement your API call for User Login and get back a HyperTrack
         * UserId from your API Server to be configured in the HyperTrack SDK.
         */
        HyperTrack.getOrCreateUser(userName, _phone: phoneNumber, lookupID) { (user, error) in
            if (error != nil) {
                // Handle getOrCreateUser API error here
                self.showAlert("Error", message: (error?.errorMessage)!)
                return
            }

            if (user != nil) {
                // Handle getOrCreateUser API success here
                HyperTrack.startTracking()
            }
        }
    }
}

extension UIViewController {
    func showAlert(_ title: String = "Alert", message: String) {
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}

