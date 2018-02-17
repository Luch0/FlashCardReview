//
//  FlashCardCollectionViewCell.swift
//  FlashCardReview
//
//  Created by Luis Calle on 2/15/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import UIKit

class FlashCardCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = UIColor.groupTableViewBackground
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.75
        layer.shadowRadius = 3
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
    }
    
}
