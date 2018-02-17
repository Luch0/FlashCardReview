//
//  ProfileViewController.swift
//  FlashCardReview
//
//  Created by Luis Calle on 2/12/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    let profileView = ProfileView()
    
    let firebaseAuthService = FirebaseAuthService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseAuthService.delegate = self
        profileView.userFlashCardscollectionView.delegate = self
        profileView.userFlashCardscollectionView.dataSource = self
        view.addSubview(profileView)
        setupNavBar()
    }

    private func setupNavBar() {
        navigationItem.title = FirebaseAuthService.getCurrentUser()!.displayName
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.plain, target: self, action: #selector(logout))
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
        let loginVC = LoginViewController()
        self.present(loginVC, animated: true) {
            let tabBarController: UITabBarController = self.tabBarController! as UITabBarController
            tabBarController.selectedIndex = 0
        }
    }
    func didFailSigningOut(_ authService: FirebaseAuthService, error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let flashCardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "flashCardCell", for: indexPath) as! FlashCardCollectionViewCell
        return flashCardCell
    }
    
    
}

extension ProfileViewController: UICollectionViewDelegate {
    
}
