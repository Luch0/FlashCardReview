//
//  AppUser.swift
//  FlashCardReview
//
//  Created by Luis Calle on 2/12/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import Foundation

struct AppUser {
    let userID: String
    let username: String
    let firstName: String
    let lastName: String
    let dateJoined: String
    
    init(dict: [String : Any]) {
        userID = dict["userID"] as? String ?? ""
        username = dict["username"] as? String ?? ""
        firstName = dict["firstName"] as? String ?? ""
        lastName = dict["lastName"] as? String ?? ""
        dateJoined = dict["dateJoined"] as? String ?? ""
    }
}
