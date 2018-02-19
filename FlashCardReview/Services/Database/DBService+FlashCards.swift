//
//  DBService+FlashCards.swift
//  FlashCardReview
//
//  Created by Luis Calle on 2/15/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import Foundation
import Firebase


//let flashCardID: String
//let userID: String
//let question: String
//let answer: String
//let categoryID: String
//let dateCreated: String

extension DBService {
    public func addFlashCard(question: String, answer: String, categoryID: String) {
        let childByAutoId = DBService.manager.getFlashCards().childByAutoId()
        childByAutoId.setValue(["flashCardID" : childByAutoId.key,
                                "userID"      : FirebaseAuthService.getCurrentUser()!.uid,
                                "username"    : FirebaseAuthService.getCurrentUser()!.displayName,
                                "question"    : question,
                                "answer"      : answer,
                                "categoryID"  : categoryID,
                                "dateCreated" : formatDate(with: Date())]) { (error, dbRef) in
                                    if let error = error {
                                        print("addFlashCard error: \(error)")
                                    } else {
                                        print("flashCard added @ database reference: \(dbRef)")
                                    }
        }
    }
    
    public func loadAllFlashCards(with category: FlashCardCategory, completionHandler: @escaping ([FlashCard]?) -> Void) {
        let ref = DBService.manager.getFlashCards()
        ref.observe(.value) { (snapshot) in
            var flashCards = [FlashCard]()
            for child in snapshot.children {
                let dataSnapshot = child as! DataSnapshot
                if let dict = dataSnapshot.value as? [String: Any] {
                    let flashCard = FlashCard.init(dict: dict)
                    if flashCard.categoryID == category.categoryID {
                        flashCards.append(flashCard)
                    }
                }
            }
            completionHandler(flashCards)
        }
    }
    
    public func loadUserFlashCards(completionHandler: @escaping ([FlashCard]?) -> Void) {
        let ref = DBService.manager.getFlashCards()
        ref.observe(.value) { (snapshot) in
            var flashCards = [FlashCard]()
            for child in snapshot.children {
                let dataSnapshot = child as! DataSnapshot
                if let dict = dataSnapshot.value as? [String: Any] {
                    let flashCard = FlashCard.init(dict: dict)
                    if flashCard.userID == FirebaseAuthService.getCurrentUser()!.uid {
                        flashCards.append(flashCard)
                    }
                }
            }
            completionHandler(flashCards)
        }
    }
}
