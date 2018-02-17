//
//  NewFlashCardView.swift
//  FlashCardReview
//
//  Created by Luis Calle on 2/15/18.
//  Copyright © 2018 Luis Calle. All rights reserved.
//

import UIKit
import SnapKit

class NewFlashCardView: UIView {
    
    lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        label.text = "Question"
        label.textColor = .black
        return label
    }()
    
    lazy var questionTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 1/2
        textView.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return textView
    }()
    
    lazy var answerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        label.text = "Answer"
        label.textColor = .black
        return label
    }()
    
    lazy var answerTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 1/2
        textView.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return textView
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
        questionTextView.layer.cornerRadius = 5
        questionTextView.layer.masksToBounds = true
        questionTextView.setContentOffset(CGPoint.zero, animated: false)
        answerTextView.layer.cornerRadius = 5
        answerTextView.layer.masksToBounds = true
        answerTextView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    private func setupViews() {
        setupQuestionLabel()
        setupQuestionTextView()
        setupAnswerLabel()
        setupAnswerTextView()
    }
    
    private func setupQuestionLabel() {
        let padding: CGFloat = 12
        addSubview(questionLabel)
        questionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(safeAreaLayoutGuide).offset(padding)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-padding)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.1)
        }
    }
    
    private func setupQuestionTextView() {
        let padding: CGFloat = 8
        addSubview(questionTextView)
        questionTextView.snp.makeConstraints { (make) in
            make.leading.equalTo(safeAreaLayoutGuide).offset(padding)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-padding)
            make.top.equalTo(questionLabel.snp.bottom)
        }
    }
    
    private func setupAnswerLabel() {
        let padding: CGFloat = 12
        addSubview(answerLabel)
        answerLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(safeAreaLayoutGuide).offset(padding)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-padding)
            make.top.equalTo(questionTextView.snp.bottom)
            make.height.equalTo(questionLabel.snp.height)
        }
    }
    
    private func setupAnswerTextView() {
        let padding: CGFloat = 8
        addSubview(answerTextView)
        answerTextView.snp.makeConstraints { (make) in
            make.leading.equalTo(safeAreaLayoutGuide).offset(padding)
            make.bottom.trailing.equalTo(safeAreaLayoutGuide).offset(-padding)
            make.top.equalTo(answerLabel.snp.bottom)
            make.height.equalTo(questionTextView.snp.height).multipliedBy(1.2)
        }
    }

}
