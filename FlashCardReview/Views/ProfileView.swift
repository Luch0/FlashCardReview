//
//  ProfileView.swift
//  FlashCardReview
//
//  Created by Luis Calle on 2/12/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
import Firebase

class ProfileView: UIView {
    
    lazy var profileBGImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "bgImage")
        return imageView
    }()
    
    lazy var userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "profileImagePlaceholder")
        return imageView
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "username here"
        return label
    }()
    
    lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "full name here"
        return label
    }()
    
    lazy var userFlashCardscollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cellSpacing: CGFloat = 10.0
        let itemWidth: CGFloat = bounds.width - (cellSpacing * 2)
        let itemHeight: CGFloat = bounds.height * 0.35
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = cellSpacing * 2
        layout.minimumInteritemSpacing = cellSpacing
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.sectionInset = UIEdgeInsetsMake(cellSpacing, cellSpacing, cellSpacing, cellSpacing)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.register(FlashCardCollectionViewCell.self, forCellWithReuseIdentifier: "flashCardCell")
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        return collectionView
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userProfileImageView.layer.cornerRadius = userProfileImageView.bounds.width/2.0
        userProfileImageView.layer.masksToBounds = true
        userProfileImageView.layer.borderColor = UIColor.white.cgColor
        userProfileImageView.layer.borderWidth = 4
    }
    
    private func setupViews() {
        setupProfileBGImageView()
        setupUserFlashCardsCollectionView()
        setupUserProfileImageView()
    }
    
    private func setupProfileBGImageView() {
        addSubview(profileBGImageView)
        profileBGImageView.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.3)
        }
    }
    
    private func setupUserFlashCardsCollectionView() {
        addSubview(userFlashCardscollectionView)
        userFlashCardscollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(profileBGImageView.snp.bottom)
            make.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func setupUserProfileImageView() {
        addSubview(userProfileImageView)
        userProfileImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(profileBGImageView.snp.bottom)
            make.centerX.equalTo(profileBGImageView.snp.centerX)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.25)
            make.height.equalTo(userProfileImageView.snp.width)
        }
    }
    
    public func configureProfileImages(for user: User) {
        userProfileImageView.kf.indicatorType = .activity
        DBService.manager.getUserImageURL(userID: user.uid) { (appUser) in
            self.userProfileImageView.kf.setImage(with: URL(string: (appUser?.userImageURL)!), placeholder: #imageLiteral(resourceName: "profileImagePlaceholder"), options: nil, progressBlock: nil, completionHandler: { (image, error, cache, url) in
            })
        }
    }

}
