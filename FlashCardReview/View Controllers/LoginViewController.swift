//
//  LoginViewController.swift
//  FlashCardReview
//
//  Created by Luis Calle on 2/12/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import FBSDKCoreKit

class LoginViewController: UIViewController {

    let loginView = LoginView()
    
    let imagePicker = UIImagePickerController()
    
    let firebaseAuthService = FirebaseAuthService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.createUserContainerView.isHidden = true
        imagePicker.delegate = self
        firebaseAuthService.delegate = self
        loginView.facebookLoginButton.delegate = self
        view.addSubview(loginView)
        setupButtonsActions()
        setupProfileImageGestureRecognizer()
    }
    
    private func setupButtonsActions() {
        loginView.loginContainerButton.alpha = 1.0
        loginView.createAccountContainerButton.alpha = 0.35
        loginView.loginContainerButton.addTarget(self, action: #selector(showLogin), for: .touchUpInside)
        loginView.createAccountContainerButton.addTarget(self, action: #selector(showSignUp), for: .touchUpInside)
        loginView.createUserContainerView.signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        loginView.loginContainerView.loginButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        loginView.loginContainerView.forgotPasswordButton.addTarget(self, action: #selector(forgotPassword), for: .touchUpInside)
    
    }
    
    @objc private func showLogin() {
        loginView.createUserContainerView.isHidden = true
        loginView.loginContainerView.isHidden = false
        loginView.loginContainerButton.alpha = 1.0
        loginView.createAccountContainerButton.alpha = 0.35
    }
    
    @objc private func showSignUp() {
        loginView.loginContainerView.isHidden = true
        loginView.createUserContainerView.isHidden = false
        loginView.createAccountContainerButton.alpha = 1.0
        loginView.loginContainerButton.alpha = 0.35
    }
    
    @objc private func signUp() {
        print("Sign up button pressed")
        guard let emailText = loginView.createUserContainerView.emailLoginTextField.text else {
            print("E-mail is nil")
            return
        }
        guard !emailText.isEmpty else {
            print("E-mail field is empty")
            return
        }
        guard let passwordText = loginView.createUserContainerView.passwordTextField.text else {
            print("Password is nil")
            return
        }
        guard !passwordText.isEmpty else {
            print("Password field is empty")
            return
        }
        guard let verifyPasswordText = loginView.createUserContainerView.verifyPasswordTextField.text else {
            print("Verify password is nil")
            return
        }
        guard !verifyPasswordText.isEmpty else {
            print("Verify password field is empty")
            return
        }
        guard passwordText == verifyPasswordText else {
            print("Password don't match")
            return
        }
        let fName = loginView.createUserContainerView.firstNameTextField.text
        let lname = loginView.createUserContainerView.lastNameTextField.text
        let userImage = loginView.createUserContainerView.profileImageView.image
        firebaseAuthService.createUser(email: emailText, password: passwordText, firstName: fName ?? "", lastName: lname ?? "", userImage: userImage ?? #imageLiteral(resourceName: "profilePlaceholder"))
    }
    
    @objc private func signIn() {
        print("Sign in button pressed")
        guard let passwordText = loginView.loginContainerView.passwordTextField.text else {
            print("password is nil")
            return
        }
        guard !passwordText.isEmpty else {
            print("Password field is empty")
            return
        }
        firebaseAuthService.signIn(email: loginView.loginContainerView.emailLoginTextField.text!, password: passwordText)
    }

    
    @objc private func forgotPassword() {
        let alertController = UIAlertController(title: "Reset Password", message: "Do you want to reset your password?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Reset", style: .destructive) { alert in
            self.firebaseAuthService.resetPassword(with: self.loginView.loginContainerView.emailLoginTextField.text!)
        }
        let noAction = UIAlertAction(title: "No", style: .default) { alert in }
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func setupProfileImageGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped(tapGestureRecognizer:)))
        loginView.createUserContainerView.profileImageView.isUserInteractionEnabled = true
        loginView.createUserContainerView.profileImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func profileImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let profileImageAlertController = UIAlertController(title: "Add Profile Image", message: nil, preferredStyle: .alert)
        let fromCameraRollAction = UIAlertAction(title: "From camera roll", style: .default) { (alertAction) in
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let fromLaunchCameraAction = UIAlertAction(title: "Take a picture", style: .default) { (alertAction) in
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        profileImageAlertController.addAction(fromCameraRollAction)
        profileImageAlertController.addAction(fromLaunchCameraAction)
        profileImageAlertController.addAction(cancelAction)
        present(profileImageAlertController, animated: true, completion: nil)
    }
    
    private func showAlert(title: String, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) {alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func clearSignUpFields() {
        loginView.createUserContainerView.emailLoginTextField.text = ""
        loginView.createUserContainerView.passwordTextField.text = ""
        loginView.createUserContainerView.verifyPasswordTextField.text = ""
        loginView.createUserContainerView.firstNameTextField.text = ""
        loginView.createUserContainerView.lastNameTextField.text = ""
        loginView.createUserContainerView.profileImageView.image = #imageLiteral(resourceName: "profilePlaceholder")
    }
    
}

extension LoginViewController: FirebaseAuthServiceDelegate {
    
    func didCreateUser(_ authService: FirebaseAuthService, user: User) {
        print("didCreateUser: \(user)")
        FirebaseAuthService.getCurrentUser()!.sendEmailVerification(completion: {(error) in
            if let error = error {
                print("Error sending email verification, \(error)")
                self.showAlert(title: "Error", message: "Error sending email verification")
                self.firebaseAuthService.signOut()
            } else {
                print("E-mail verification sent")
                self.showAlert(title: "Verification Sent", message: "Please verify email")
                self.showLogin()
                self.clearSignUpFields()
            }
        })
    }
    
    func didFailCreatingUser(_ authService: FirebaseAuthService, error: Error) {
        showAlert(title: error.localizedDescription, message: nil)
    }
    
    func didSignIn(_ authService: FirebaseAuthService, user: User) {
        if FirebaseAuthService.getCurrentUser()!.isEmailVerified {
            self.dismiss(animated: true, completion: nil)
        } else {
            showAlert(title: "E-mail Verification Needed", message: "Please verify e-mail")
            firebaseAuthService.signOut()
        }
    }
    
    func didFailSignIn(_ authService: FirebaseAuthService, error: Error) {
        showAlert(title: error.localizedDescription, message: nil)
    }
    
    func didSignInFacebook(_ authService: FirebaseAuthService, user: User) {
        DBService.manager.addFacebookUser()
        self.dismiss(animated: true, completion: nil)
    }
    
    func didFailSignInFacebook(_ authService: FirebaseAuthService, error: Error) {
        showAlert(title: error.localizedDescription, message: nil)
    }
    
    func didSendResetPassword(_ authService: FirebaseAuthService) {
        showAlert(title: "Password Reset", message: "Reset e-mail sent, check spam inbox!")
    }
    
    func didFailSendResetPassword(_ authService: FirebaseAuthService, error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
    }
}

extension LoginViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let imageSelected = info[UIImagePickerControllerEditedImage] as? UIImage else {
            print("Error selecting picture")
            return
        }
        loginView.createUserContainerView.profileImageView.image = imageSelected
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension LoginViewController: FBSDKLoginButtonDelegate {
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        firebaseAuthService.signInWithFacebook(with: credential)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("logged out facebook")
    }
}
