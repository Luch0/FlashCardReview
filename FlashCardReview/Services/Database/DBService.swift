//
//  DBService.swift
//  FlashCardReview
//
//  Created by Luis Calle on 2/15/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DBService {
    
    //MARK: Properties
    private var dbRef: DatabaseReference!
    private var usersRef: DatabaseReference!
    private var categoriesRef: DatabaseReference!
    private var flashCardsRef: DatabaseReference!
    
    
    private init(){
        // reference to the root of the Firebase database
        dbRef = Database.database().reference()
        
        // children of root database node
        usersRef = dbRef.child("users")
        categoriesRef = dbRef.child("categories")
        flashCardsRef = dbRef.child("flashCards")
    }
    static let manager = DBService()
    
    public func formatDate(with date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, YYYY h:mm a"
        return dateFormatter.string(from: date)
    }
    
    public func getDB()-> DatabaseReference { return dbRef }
    public func getUsers()-> DatabaseReference { return usersRef }
    public func getCategories()-> DatabaseReference { return categoriesRef }
    public func getFlashCards()-> DatabaseReference { return flashCardsRef }
}
