//
//  SignupViewController.swift
//  locationApp
//
//  Created by Ang Wei Hao Desmond on 23/9/17.
//  Copyright © 2017 desmond.ang.a0093896H. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {

    var firebaseDB = Database.database().reference()

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!

    @IBAction func signupButtonPressed(_ sender: Any) {
        guard let email = emailTextField.text, isValidEmailAddress(emailAddressString: email) else {
            self.showAlert(message: "Please enter a valid email")
            return
        }

        guard let password = passwordTextField.text, isValidPassword(password: password) else {
            self.showAlert(message: "Please enter a valid email")
            return
        }

        guard let phone = phoneTextField.text, isValidPhoneNumber(phoneNumber: phone) else {
            self.showAlert(message: "Please enter a valid phone number")
            return
        }

        AuthController.signUpUser(email: email, password: password, phone: phone, successHandler: { () in
            self.showAlert(message: "Sign up success")
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        phoneTextField.keyboardType = .numberPad
        emailTextField.keyboardType = .emailAddress
    }
}

//Form Validation
extension SignupViewController {
    func isValidPhoneNumber(phoneNumber: String) -> Bool {
        return phoneNumber.count == 10
    }

    func isValidPassword(password: String) -> Bool {
        return password != ""
    }

    func isValidEmailAddress(emailAddressString: String) -> Bool {

        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"

        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))

            if results.count == 0
            {
                returnValue = false
            }

        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }

        return  returnValue
    }
}
