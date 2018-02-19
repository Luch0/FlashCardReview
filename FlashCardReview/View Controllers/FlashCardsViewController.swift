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
    
    private var flashCards = [FlashCard]() {
        didSet {
            flashCardsView.flashCardscollectionView.reloadData()
        }
    }
    
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
        loadFlashCards()
    }

    private func setupNavBar() {
        navigationItem.title = category.categoryName
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewFlashCard))
    }
    
    private func loadFlashCards() {
        DBService.manager.loadAllFlashCards(with: category) { (dbFlashCards) in
            if let dbFlashCards = dbFlashCards {
                self.flashCards = dbFlashCards
            } else {
                print("Error retreving flashCards")
            }
        }
    }
    
    @objc private func addNewFlashCard() {
        let newFlashCardVC = NewFlashCardViewController(category: category)
        newFlashCardVC.delegate = self
        let newFlashCardVCNavCon = UINavigationController(rootViewController: newFlashCardVC)
        newFlashCardVCNavCon.modalTransitionStyle = .coverVertical
        //newFlashCardVCNavCon.modalPresentationStyle = .overCurrentContext
        newFlashCardVCNavCon.modalPresentationStyle = .overFullScreen
        present(newFlashCardVCNavCon,animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension FlashCardsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flashCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let flashCardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "flashCardCell", for: indexPath) as! FlashCardCollectionViewCell
        let flashCard = flashCards[indexPath.row]
        flashCardCell.configureCell(flashCard: flashCard)
        return flashCardCell
    }
}

extension FlashCardsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let flashCardCell = collectionView.cellForItem(at: indexPath) as! FlashCardCollectionViewCell
        //UIView.transition(with: flashCardCell, duration: 0.3, options: .transitionFlipFromBottom, animations: nil, completion: nil)
    }
}

extension FlashCardsViewController: NewFlashCardViewControllerDelegate {
    func didAddNewFlashCard(_ newFlashCardViewController: NewFlashCardViewController) {
        DBService.manager.updateNumberOfFlashCards(in: category)
        showAlert(title: "Success", message: "Added new FlashCard")
    }
}
