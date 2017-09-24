//
//  GroceryController.swift
//  locationApp
//
//  Created by Ang Wei Hao Desmond on 23/9/17.
//  Copyright © 2017 desmond.ang.a0093896H. All rights reserved.
//

import Foundation
import Firebase

class GroceryController {

    private static let groceryTable = "grocery"
    static let firebaseDB = Database.database().reference()

    static func addGrocery(grocery: Grocery) {
        self.firebaseDB.child(groceryTable).childByAutoId().setValue(grocery.name)
    }

    static func deleteGrocery(grocery: Grocery) {
        firebaseDB.child(groceryTable).observe(.value, with: { snapshot in
            if let groceries = snapshot.value as? [String] {
                for i in 0..<groceries.count {
                    if groceries[i] == grocery.name {
                        firebaseDB.child(groceryTable).child("\(i)").removeValue()
                    }
                }
            }

        })
    }

}
