//
//  Grocery.swift
//  locationApp
//
//  Created by Ang Wei Hao Desmond on 23/9/17.
//  Copyright © 2017 desmond.ang.a0093896H. All rights reserved.
//

import Foundation

struct Grocery {

    let name: String

    static func createNewGrocery(name: String) -> Grocery {
        return Grocery(name: name)
    }

    private init(name: String) {
        self.name = name
    }

    func groceryDict() -> [String: String] {
        return ["name": self.name]
    }

}
