//
//  LoginView.swift
//  FlashCardReview
//
//  Created by Luis Calle on 2/12/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import UIKit
import SnapKit

class LoginView: UIView {
    
    let loginContainerView = LoginContainerView()
    let createUserContainerView = CreateUserContainerView()
    
    lazy var loginContainerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .groupTableViewBackground
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1/4
        return button
    }()
    
    lazy var createAccountContainerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        setupCreateUserContainerView()
        setupLoginContainerView()
        setupLoginContainerButton()
        setupCreateAccountContainerButton()
    }
    
    private func setupCreateUserContainerView() {
        addSubview(createUserContainerView)
        createUserContainerView.snp.makeConstraints { (make) in
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY)
            make.width.equalTo(safeAreaLayoutGuide.snp.width)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.6)
        }
    }
    
    private func setupLoginContainerView() {
        addSubview(loginContainerView)
        loginContainerView.snp.makeConstraints { (make) in
            make.edges.equalTo(createUserContainerView.snp.edges)
        }
    }

    
    private func setupLoginContainerButton() {
        addSubview(loginContainerButton)
        loginContainerButton.snp.makeConstraints { (make) in
            make.top.equalTo(loginContainerView.snp.bottom)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.5)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
        }
    }

    private func setupCreateAccountContainerButton() {
        addSubview(createAccountContainerButton)
        createAccountContainerButton.snp.makeConstraints { (make) in
            make.top.equalTo(createUserContainerView.snp.bottom)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.5)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
        }
    }

}