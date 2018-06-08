//
//  CreateUserContainerView.swift
//  FlashCardReview
//
//  Created by Luis Calle on 2/12/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import UIKit
import SnapKit

class CreateUserContainerView: UIView {
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "profileImagePlaceholder")
        return imageView
    }()
    
    lazy var firstNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.text = "First"
        label.textAlignment = .right
        label.textColor = .black
        return label
    }()
    
    lazy var firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        textField.placeholder = "Enter first name"
        //textField.text = "Luis"
        textField.layer.cornerRadius = 5
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        textField.textColor = .black
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    
    
    lazy var lastNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.text = "Last"
        label.textAlignment = .right
        label.textColor = .black
        return label
    }()
    
    lazy var lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        textField.placeholder = "Enter last name"
        //textField.text = "Calle"
        textField.layer.cornerRadius = 5
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        textField.textColor = .black
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy var emailAddressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.text = "E-mail"
        label.textAlignment = .right
        label.textColor = .black
        return label
    }()
    
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .right
        label.text = "Password"
        label.textColor = .black
        return label
    }()
    
    lazy var verifyPasswordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .right
        label.text = "Verify password"
        label.textColor = .black
        return label
    }()
    
    lazy var emailLoginTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        textField.placeholder = "Enter e-mail address"
        //textField.text = "luiscalle@ac.c4q.nyc"
        textField.layer.cornerRadius = 5
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        textField.textColor = .black
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        textField.placeholder = "Enter password"
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        textField.isSecureTextEntry = true
        textField.textColor = .black
        return textField
    }()
    
    lazy var verifyPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        textField.placeholder = "Verify password"
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        textField.isSecureTextEntry = true
        textField.textColor = .black
        return textField
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel!.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .groupTableViewBackground
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1/4
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.bounds.width/2.0
        profileImageView.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        setupViews()
    }
    
    private func setupViews() {
        //setupProfileImageView()
        setupEmailLoginTextField()
        setupEmailAddressLabel()
        setupPasswordTextField()
        setupPasswordLabel()
        setupVerifyPasswordTextField()
        setupVerifyPasswordLabel()
        setupSignUpButton()
        setupFirstNameTextField()
        setupFirstNameLabel()
        setupLastNameTextField()
        setupLastNameLabel()
        setupProfileImageView()
    }
    
//    private func setupProfileImageView() {
//        addSubview(profileImageView)
//        profileImageView.snp.makeConstraints { (make) in
//            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(8)
//            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
//            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.25)
//            make.height.equalTo(profileImageView.snp.width)
//        }
//    }
    
    private func setupEmailLoginTextField() {
        addSubview(emailLoginTextField)
        emailLoginTextField.snp.makeConstraints { (make) in
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.75)
        }
    }
    
    private func setupEmailAddressLabel() {
        addSubview(emailAddressLabel)
        emailAddressLabel.snp.makeConstraints { (make) in
            make.top.equalTo(emailLoginTextField.snp.bottom).offset(2)
            make.leading.equalTo(emailLoginTextField.snp.leading).offset(8)
        }
    }
    
    
    private func setupFirstNameTextField() {
        addSubview(firstNameTextField)
        firstNameTextField.snp.makeConstraints { (make) in
            make.bottom.equalTo(emailLoginTextField.snp.top).offset(-24)
            make.leading.equalTo(emailLoginTextField.snp.leading)
            make.width.equalTo(emailLoginTextField.snp.width).multipliedBy(0.48)
        }
    }
    
    private func setupFirstNameLabel() {
        addSubview(firstNameLabel)
        firstNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(firstNameTextField.snp.bottom).offset(2)
            make.leading.equalTo(firstNameTextField.snp.leading).offset(8)
        }
    }
    
    
    private func setupLastNameTextField() {
        addSubview(lastNameTextField)
        lastNameTextField.snp.makeConstraints { (make) in
            make.bottom.equalTo(emailLoginTextField.snp.top).offset(-24)
            make.trailing.equalTo(emailLoginTextField.snp.trailing)
            make.width.equalTo(emailLoginTextField.snp.width).multipliedBy(0.48)
        }
    }
    
    private func setupLastNameLabel() {
        addSubview(lastNameLabel)
        lastNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(lastNameTextField.snp.bottom).offset(2)
            make.leading.equalTo(lastNameTextField.snp.leading).offset(8)
        }
    }
    
    private func setupPasswordTextField() {
        addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailAddressLabel.snp.bottom).offset(8)
            make.leading.equalTo(emailLoginTextField.snp.leading)
            make.width.equalTo(emailLoginTextField.snp.width)
        }
    }
    
    private func setupPasswordLabel() {
        addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(2)
            make.leading.equalTo(passwordTextField.snp.leading).offset(8)
        }
    }
    
    private func setupVerifyPasswordTextField() {
        addSubview(verifyPasswordTextField)
        verifyPasswordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(passwordLabel.snp.bottom).offset(8)
            make.leading.equalTo(passwordTextField.snp.leading)
            make.width.equalTo(passwordTextField.snp.width)
        }
    }
    
    private func setupVerifyPasswordLabel() {
        addSubview(verifyPasswordLabel)
        verifyPasswordLabel.snp.makeConstraints { (make) in
            make.top.equalTo(verifyPasswordTextField.snp.bottom).offset(2)
            make.leading.equalTo(verifyPasswordTextField.snp.leading).offset(8)
        }
    }
    
    private func setupSignUpButton() {
        addSubview(signUpButton)
        signUpButton.snp.makeConstraints { (make) in
            make.top.equalTo(verifyPasswordLabel.snp.bottom).offset(16)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.3)
        }
    }
    
    private func setupProfileImageView() {
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.bottom.equalTo(firstNameTextField.snp.top).offset(-16)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.25)
            make.height.equalTo(profileImageView.snp.width)
        }
    }

}
