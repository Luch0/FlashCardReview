//
//  FavFlashCardsViewController.swift
//  FlashCardReview
//
//  Created by Luis Calle on 2/15/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import UIKit

class FavFlashCardsViewController: UIViewController {

    let favFlashCardsView = FavFlashCardsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(favFlashCardsView)
        setupNavBar()
    }
    
    private func setupNavBar() {
        navigationItem.title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}
