//
//  FlashCardCategory.swift
//  FlashCardReview
//
//  Created by Luis Calle on 2/15/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import Foundation

struct FlashCardCategory {
    let userID: String
    let categoryName: String
    let categoryID: String
    let dateCreated: String
    var numOfFlashCards: Int
    
    init(dict: [String : Any]) {
        userID = dict["userID"] as? String ?? ""
        categoryName = dict["categoryName"] as? String ?? ""
        categoryID = dict["categoryID"] as? String ?? ""
        dateCreated = dict["dateCreated"] as? String ?? ""
        numOfFlashCards = dict["numOfFlashCards"] as? Int ?? 0
    }
    
    public mutating func addedNewFlashCard() {
        self.numOfFlashCards = self.numOfFlashCards + 1
    }
}
