//
//  StorageService.swift
//  FlashCardReview
//
//  Created by Luis Calle on 2/19/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import Foundation
import FirebaseStorage

class StorageService {
    private init(){
        storage = Storage.storage()
        storageRef = storage.reference()
        userImagesRef = storageRef.child("userImages")
    }
    static let manager = StorageService()
    
    let firebaseAuthService = FirebaseAuthService()
    
    private var storage: Storage!
    private var storageRef: StorageReference!
    private var userImagesRef: StorageReference!
    
    public func getStorageRef() -> StorageReference { return storageRef }
    public func getUserImagesRef() -> StorageReference { return userImagesRef }
}
