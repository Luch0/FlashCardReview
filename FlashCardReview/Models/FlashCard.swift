//
//  FlashCard.swift
//  FlashCardReview
//
//  Created by Luis Calle on 2/12/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import Foundation

class FlashCard {
    let flashCardID: String
    let userID: String
    let username: String
    let question: String
    let answer: String
    let categoryID: String
    let dateCreated: String
    
    init(dict: [String : Any]) {
        flashCardID = dict["flashCardID"] as? String ?? ""
        userID = dict["userID"] as? String ?? ""
        username = dict["username"] as? String ?? ""
        question = dict["question"] as? String ?? ""
        answer = dict["answer"] as? String ?? ""
        categoryID = dict["categoryID"] as? String ?? ""
        dateCreated = dict["dateCreated"] as? String ?? ""
    }
}
