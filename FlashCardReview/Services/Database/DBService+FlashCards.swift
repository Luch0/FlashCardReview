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
}
