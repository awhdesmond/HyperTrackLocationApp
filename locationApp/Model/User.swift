//
//  User.swift
//  locationApp
//
//  Created by Ang Wei Hao Desmond on 23/9/17.
//  Copyright © 2017 desmond.ang.a0093896H. All rights reserved.
//

import Foundation

struct AppUser {

    let userName: String
    let phone: String
    let email: String

    static func createNewAppUser(userName: String, phone: String, email: String) -> AppUser {
        return AppUser(userName: userName, phone: phone, email: email)
    }

    private init(userName: String, phone: String, email: String) {
        self.userName = userName
        self.phone = phone
        self.email = email
    }

    func userDict() -> [String: String] {
        return ["userName": self.userName, "phone": self.phone, "email": self.email]
    }

}
