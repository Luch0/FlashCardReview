//
//  FirebaseAuthService.swift
//  FlashCardReview
//
//  Created by Luis Calle on 2/12/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import Foundation
import Firebase
import FBSDKLoginKit
import FBSDKCoreKit

@objc protocol FirebaseAuthServiceDelegate: class {
    // create user delegate protocols
    @objc optional func didFailCreatingUser(_ authService: FirebaseAuthService, error: Error)
    @objc optional func didCreateUser(_ authService: FirebaseAuthService, user: User)
    
    // sign in delegate protocols
    @objc optional func didFailSignIn(_ authService: FirebaseAuthService, error: Error)
    @objc optional func didSignIn(_ authService: FirebaseAuthService, user: User)
    
    // sign in facebook delegate protocols
    @objc optional func didFailSignInFacebook(_ authService: FirebaseAuthService, error: Error)
    @objc optional func didSignInFacebook(_ authService: FirebaseAuthService, user: User)
    
    // sign in google delegate protocols
    @objc optional func didFailSignInGoogle(_ authService: FirebaseAuthService, error: Error)
    @objc optional func didSignInGoogle(_ authService: FirebaseAuthService, user: User)
    
    // sign out delegate protocols
    @objc optional func didFailSigningOut(_ authService: FirebaseAuthService, error: Error)
    @objc optional func didSignOut(_ authService: FirebaseAuthService)
    
    // reset password delegate protocols
    @objc optional func didFailSendResetPassword(_ authService: FirebaseAuthService, error: Error)
    @objc optional func didSendResetPassword(_ authService: FirebaseAuthService)
}

class FirebaseAuthService: NSObject {
    
    weak var delegate: FirebaseAuthServiceDelegate?
    
    public static func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    public func createUser(email: String, password: String, firstName: String, lastName: String, userImage: UIImage) {
        Auth.auth().createUser(withEmail: email, password: password){(user, error) in
            if let error = error {
                self.delegate?.didFailCreatingUser?(self, error: error)
            } else if let user = user {
                let changeRequest = user.user.createProfileChangeRequest()
                let stringArray = user.user.email!.components(separatedBy: "@")
                let username = stringArray[0]
                changeRequest.displayName = username
                changeRequest.commitChanges(completion: {(error) in
                    if let error = error {
                        print("changeRequest error: \(error)")
                    } else {
                        print("changeRequest was successful for username: \(username)")
                        DBService.manager.addUser(firstName: firstName, lastName: lastName, userImage: userImage)
                        self.delegate?.didCreateUser?(self, user: user.user)
                    }
                })
            }
        }
    }
    
    // TODO: implement
    public func updateUsername() {
    
    }
    
    public func resetPassword(with email: String) {
        Auth.auth().sendPasswordReset(withEmail: email){(error) in
            if let error = error {
                self.delegate?.didFailSendResetPassword?(self, error: error)
                return
            }
            self.delegate?.didSendResetPassword?(self)
        }
    }
    
    public func signOut() {
        do {
            try Auth.auth().signOut()
            delegate?.didSignOut?(self)
            print("Successfully signed out")
        } catch {
            delegate?.didFailSigningOut?(self, error: error)
        }
    }
    
    public func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {(user, error) in
            if let error = error {
                self.delegate?.didFailSignIn?(self, error: error)
            } else if let user = user {
                self.delegate?.didSignIn?(self, user: user.user)
            }
        }
    }
    
    
    public func signInWithFacebook(with credential: AuthCredential) {
        Auth.auth().signInAndRetrieveData(with: credential) { (authDataResult, error) in
            if let error = error {
                self.delegate?.didFailSignInFacebook?(self, error: error)
                print("error: \(error.localizedDescription)")
                return
            }
            self.delegate?.didSignInFacebook?(self, user: authDataResult!.user)
            print("User is signed in: \(authDataResult!.user)")
        }
    }
    
    public func signInWithGoogle(with credential: AuthCredential) {
        Auth.auth().signInAndRetrieveData(with: credential) { (authDataResult, error) in
            if let error = error {
                self.delegate?.didFailSignInGoogle?(self, error: error)
                print("error: \(error.localizedDescription)")
                return
            }
            self.delegate?.didSignInGoogle?(self, user: authDataResult!.user)
            print("User is signed in: \(authDataResult!.user)")
        }
    }
    
    
//    public func signInWithFacebook(with credential: AuthCredential) {
//        Auth.auth().signIn(with: credential) { (user, error) in
//            if let error = error {
//                self.delegate?.didFailSignInFacebook?(self, error: error)
//                print("error: \(error.localizedDescription)")
//                return
//            }
//            self.delegate?.didSignInFacebook?(self, user: user!)
//            print("User is signed in: \(user!)")
//        }
//    }
    
    
}
