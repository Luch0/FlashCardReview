//
//  DBService+Users.swift
//  FlashCardReview
//
//  Created by Luis Calle on 2/15/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import Foundation
import Firebase

extension DBService {
    public func addUser(firstName: String, lastName: String) {
        let user = DBService.manager.getUsers().child(FirebaseAuthService.getCurrentUser()!.uid)
        user.setValue(["userID"     : FirebaseAuthService.getCurrentUser()!.uid,
                       "username"   : FirebaseAuthService.getCurrentUser()!.displayName!,
                       "firstName"  : firstName,
                       "lastName"   : lastName,
                       "dateJoined" : formatDate(with: Date())]) { (error, dbRef) in
                        if let error = error {
                            print("addUser error: \(error.localizedDescription)")
                        } else {
                            print("user added @ database reference: \(dbRef)")
                        }
        }
    }
}
