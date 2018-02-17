//
//  NewFlashCardViewController.swift
//  FlashCardReview
//
//  Created by Luis Calle on 2/12/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import UIKit

class NewFlashCardViewController: UIViewController {

    private let newFlashCardView = NewFlashCardView()
    
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
        view.addSubview(newFlashCardView)
        setupNavBar()
    }

    private func setupNavBar() {
        navigationItem.title = "New FlashCard"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .done, target: self, action: #selector(createFashCard))
    }
    
    @objc private func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func createFashCard() {
        // TODO: check for edge cases / bad input
        let question = newFlashCardView.questionTextView.text
        let answer = newFlashCardView.answerTextView.text
        DBService.manager.addFlashCard(question: question!, answer: answer!, categoryID: category.categoryID)
        DBService.manager.updateNumberOfFlashCards(in: category)
        dismiss(animated: true) {
            // TODO: implement protocols to let the user know if success or not adding new flashcard
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
