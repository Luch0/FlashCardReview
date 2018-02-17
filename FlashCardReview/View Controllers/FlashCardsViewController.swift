//
//  FlashCardsViewController.swift
//  FlashCardReview
//
//  Created by Luis Calle on 2/15/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import UIKit

class FlashCardsViewController: UIViewController {
    
    private let flashCardsView = FlashCardsView()
    
    private var category: FlashCardCategory!
    
    init(category: FlashCardCategory) {
        super.init(nibName: nil, bundle: nil)
        self.category = category
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flashCardsView.flashCardscollectionView.delegate = self
        flashCardsView.flashCardscollectionView.dataSource = self
        view.addSubview(flashCardsView)
        setupNavBar()
    }

    private func setupNavBar() {
        navigationItem.title = category.categoryName
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewFlashCard))
    }
    
    @objc private func addNewFlashCard() {
        let newFlashCardVC = NewFlashCardViewController(category: category)
        let newFlashCardVCNavCon = UINavigationController(rootViewController: newFlashCardVC)
        newFlashCardVCNavCon.modalTransitionStyle = .coverVertical
        //newFlashCardVCNavCon.modalPresentationStyle = .overCurrentContext
        newFlashCardVCNavCon.modalPresentationStyle = .overFullScreen
        present(newFlashCardVCNavCon,animated: true, completion: nil)
    }

}

extension FlashCardsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let flashCardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "flashCardCell", for: indexPath) as! FlashCardCollectionViewCell
        return flashCardCell
    }
}

extension FlashCardsViewController: UICollectionViewDelegate {
    
}
