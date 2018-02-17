//
//  DBService+Categories.swift
//  FlashCardReview
//
//  Created by Luis Calle on 2/15/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import Foundation
import Firebase

extension DBService {
    public func addCategory(name: String) {
        let childByAutoId = DBService.manager.getCategories().childByAutoId()
        childByAutoId.setValue(["categoryID"      : childByAutoId.key,
                                "userID"          : FirebaseAuthService.getCurrentUser()!.uid,
                                "categoryName"    : name,
                                "dateCreated"     : formatDate(with: Date()),
                                "numOfFlashCards" : 0]) { (error, dbRef) in
                                    if let error = error {
                                        print("addCategory error: \(error)")
                                    } else {
                                        print("category added @ database reference: \(dbRef)")
                                    }
        }
    }
    
    public func loadAllCategories(completionHandler: @escaping ([FlashCardCategory]?) -> Void) {
        let ref = DBService.manager.getCategories()
        ref.observe(.value) { (snapshot) in
            var allCategories = [FlashCardCategory]()
            for child in snapshot.children {
                let dataSnapshot = child as! DataSnapshot
                if let dict = dataSnapshot.value as? [String: Any] {
                    let category = FlashCardCategory.init(dict: dict)
                    allCategories.append(category)
                }
            }
            completionHandler(allCategories)
        }
    }
    
    public func updateNumberOfFlashCards(in category: FlashCardCategory) {    DBService.manager.getCategories().child(category.categoryID).updateChildValues(["numOfFlashCards":category.numOfFlashCards + 1])
    }
}
