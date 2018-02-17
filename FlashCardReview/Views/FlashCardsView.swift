//
//  FlashCardsView.swift
//  FlashCardReview
//
//  Created by Luis Calle on 2/15/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import UIKit
import SnapKit

class FlashCardsView: UIView {
    
    lazy var flashCardscollectionView: UICollectionView = {
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
    
    private func setupViews() {
        setupFlashCardscollectionView()
    }
    
    private func setupFlashCardscollectionView() {
        addSubview(flashCardscollectionView)
        flashCardscollectionView.snp.makeConstraints { (make) in
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.5)
            make.width.equalTo(safeAreaLayoutGuide.snp.width)
        }
    }

}
