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
    public func addUser(firstName: String, lastName: String, userImage: UIImage) {
        let user = DBService.manager.getUsers().child(FirebaseAuthService.getCurrentUser()!.uid)
        user.setValue(["userID"      : FirebaseAuthService.getCurrentUser()!.uid,
                       "username"    : FirebaseAuthService.getCurrentUser()!.displayName!,
                       "firstName"   : firstName,
                       "lastName"    : lastName,
                       "dateJoined"  : formatDate(with: Date())]) { (error, dbRef) in
                        if let error = error {
                            print("addUser error: \(error.localizedDescription)")
                        } else {
                            print("user added @ database reference: \(dbRef)")
                            StorageService.manager.storeUserImage(image: userImage, userID: FirebaseAuthService.getCurrentUser()!.uid)
                        }
        }
    }
    
    public func addFacebookUser() {
        let user = DBService.manager.getUsers().child(FirebaseAuthService.getCurrentUser()!.uid)
        user.setValue(["userID"      : FirebaseAuthService.getCurrentUser()!.uid,
                       "username"    : FirebaseAuthService.getCurrentUser()!.displayName!,
                       "firstName"   : "",
                       "lastName"    : "",
                       "dateJoined"  : formatDate(with: Date())]) { (error, dbRef) in
                        if let error = error {
                            print("addUser error: \(error.localizedDescription)")
                        } else {
                            print("user added @ database reference: \(dbRef)")
                        }
        }
    }
    
    public func addGoogleUser() {
        let user = DBService.manager.getUsers().child(FirebaseAuthService.getCurrentUser()!.uid)
        user.setValue(["userID"      : FirebaseAuthService.getCurrentUser()!.uid,
                       "username"    : FirebaseAuthService.getCurrentUser()!.displayName!,
                       "firstName"   : "",
                       "lastName"    : "",
                       "dateJoined"  : formatDate(with: Date())]) { (error, dbRef) in
                        if let error = error {
                            print("addUser error: \(error.localizedDescription)")
                        } else {
                            print("user added @ database reference: \(dbRef)")
                        }
        }
    }
    
    public func getUserImageURL(userID: String, completionHandler: @escaping (AppUser?) -> Void) {
        let ref = DBService.manager.getUsers()
        ref.observe(.value) { (snapshot) in
            for child in snapshot.children {
                let dataSnapshot = child as! DataSnapshot
                if let dict = dataSnapshot.value as? [String: Any] {
                    let user = AppUser.init(dict: dict)
                    if user.userID == userID {
                        completionHandler(user)
                    }
                }
            }
        }
    }
}
