//
//  AuthController.swift
//  locationApp
//
//  Created by Ang Wei Hao Desmond on 23/9/17.
//  Copyright © 2017 desmond.ang.a0093896H. All rights reserved.
//

import Foundation
import Firebase

class AuthController {

    private static let users = "users"
    static let firebaseDB = Database.database().reference()

    static func loginUser(email: String, password: String, successHandler: @escaping (String, String) -> Void,
                          errorHandler: @escaping (Error) -> Void ) {

        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                errorHandler(error)
                return
            }

            let sanitizedEmail = email.replacingOccurrences(of: ".", with: "")
            AuthController.fetchUser(email: sanitizedEmail, successHandler: { (appUser) in
                successHandler(appUser.email, appUser.phone)
            }, errorHandler: { (error) in
                print(error.localizedDescription)
            })
        }
    }

    static func signUpUser(email: String, password: String, phone:String,
                           successHandler: @escaping () -> Void,
                           errorHandler: @escaping (Error) -> Void) {

        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                errorHandler(error)
                return
            }
            let sanitizedEmail = email.replacingOccurrences(of: ".", with: "")
            self.firebaseDB.child(users).child(sanitizedEmail).setValue(["email": email, "phone": phone])
            successHandler()
        }
    }

    static func fetchUser(email: String, successHandler: @escaping (AppUser) -> Void,
                          errorHandler: @escaping (Error) -> Void) {
        self.firebaseDB.child(users).child(email).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let name = value?["name"] as? String ?? ""
            let phone = value?["phone"] as? String ?? ""
            let email = value?["email"] as? String ?? ""

            successHandler(AppUser.createNewAppUser(userName: name, phone: phone, email: email))
        }) { (error) in
            errorHandler(error)
        }
    }
}
