//
//  Order.swift
//  locationApp
//
//  Created by Ang Wei Hao Desmond on 23/9/17.
//  Copyright © 2017 desmond.ang.a0093896H. All rights reserved.
//

import Foundation

struct OrderRequest {

    let user: AppUser
    let grocery: Grocery

    static func createNewOrderRequest(user: AppUser, grocery: Grocery) -> OrderRequest {
        return OrderRequest(user: user, grocery: grocery)
    }

    private init(user: AppUser, grocery: Grocery) {
        self.user = user
        self.grocery = grocery
    }

    func orderRequestDict() -> [String: Any] {
        return ["user": self.user, "grocery": self.grocery]
    }

}
