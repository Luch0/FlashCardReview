//
//  ProfileViewController.swift
//  FlashCardReview
//
//  Created by Luis Calle on 2/12/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import FBSDKCoreKit
import GoogleSignIn

class ProfileViewController: UIViewController {

    let profileView = ProfileView()
    
    let firebaseAuthService = FirebaseAuthService()
    
    private var userFlashCards = [FlashCard]() {
        didSet {
            profileView.userFlashCardscollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseAuthService.delegate = self
        profileView.userFlashCardscollectionView.delegate = self
        profileView.userFlashCardscollectionView.dataSource = self
        view.addSubview(profileView)
        profileView.configureProfileImages(for: FirebaseAuthService.getCurrentUser()!)
        setupNavBar()
        loadUserFlashCards()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = FirebaseAuthService.getCurrentUser()!.displayName
        profileView.configureProfileImages(for: FirebaseAuthService.getCurrentUser()!)
        loadUserFlashCards()
    }

    private func setupNavBar() {
        navigationItem.title = FirebaseAuthService.getCurrentUser()!.displayName
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.plain, target: self, action: #selector(logout))
    }
    
    private func loadUserFlashCards() {
        DBService.manager.loadUserFlashCards { (dbUserFlashCards) in
            if let dbUserFlashCards = dbUserFlashCards {
                self.userFlashCards = dbUserFlashCards
            } else {
                print("Error retrieving user flash cards")
            }
        }
    }
    
    @objc private func logout() {
        let alertView = UIAlertController(title: "Are you sure you want to logout?", message: nil, preferredStyle: .alert)
        let yesOption = UIAlertAction(title: "Yes", style: .destructive) { (alertAction) in
            self.firebaseAuthService.signOut()
        }
        let noOption = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alertView.addAction(yesOption)
        alertView.addAction(noOption)
        present(alertView, animated: true, completion: nil)
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension ProfileViewController: FirebaseAuthServiceDelegate {
    func didSignOut(_ authService: FirebaseAuthService) {
        if FBSDKAccessToken.current() != nil {
            let loginManager = FBSDKLoginManager()
            loginManager.logOut()
        }
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            GIDSignIn.sharedInstance().signOut()
            print("Logged out of Google")
        }
        userFlashCards.removeAll()
        let loginVC = LoginViewController()
        self.present(loginVC, animated: true) {
            self.profileView.userProfileImageView.image = #imageLiteral(resourceName: "profileImagePlaceholder")
            let tabBarController: UITabBarController = self.tabBarController! as UITabBarController
            tabBarController.selectedIndex = 0
        }
    }
    func didFailSigningOut(_ authService: FirebaseAuthService, error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        var numOfSections: Int = 0
        if userFlashCards.count > 0 {
            profileView.userFlashCardscollectionView.backgroundView = nil
            numOfSections = 1
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: profileView.userFlashCardscollectionView.bounds.size.width, height: profileView.userFlashCardscollectionView.bounds.size.height))
            noDataLabel.text = "You haven't created any FlashCards Yet"
            noDataLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            noDataLabel.textAlignment = .center
            profileView.userFlashCardscollectionView.backgroundView = noDataLabel
        }
        return numOfSections
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userFlashCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let flashCardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "flashCardCell", for: indexPath) as! FlashCardCollectionViewCell
        let userFlashCard = userFlashCards[indexPath.row]
        flashCardCell.configureCell(flashCard: userFlashCard)
        return flashCardCell
    }
    
    
}

extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let flashCardCell = collectionView.cellForItem(at: indexPath) as! FlashCardCollectionViewCell
        //UIView.transition(with: flashCardCell, duration: 0.3, options: .transitionFlipFromBottom, animations: nil, completion: nil)
    }
}
