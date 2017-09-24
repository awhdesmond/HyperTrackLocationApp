//
//  OrderUpdate.swift
//  locationApp
//
//  Created by Ang Wei Hao Desmond on 23/9/17.
//  Copyright © 2017 desmond.ang.a0093896H. All rights reserved.
//

import Foundation

struct OrderUpdate {

    let user: AppUser
    let location: Location
    let processed: Bool //if the order is being processed
    let timeLeft: String

    static func createNewOrderUpdate(user: AppUser, location: Location, processed: Bool, timeLeft: String) -> OrderUpdate {
        return OrderUpdate(user: user, location: location, processed: processed, timeLeft: timeLeft)
    }

    private init(user: AppUser, location: Location, processed: Bool, timeLeft: String) {
        self.user = user
        self.location = location
        self.processed = processed
        self.timeLeft = timeLeft
    }

    func orderUpdateDict() -> [String: Any] {
        return ["user": self.user, "location": self.location, "processed": self.processed, "timeLeft": self.timeLeft]
    }

}
