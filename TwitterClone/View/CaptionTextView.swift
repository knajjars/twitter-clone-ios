//
//  CaptionTextView.swift
//  TwitterClone
//
//  Created by Khalil Najjar on 4/21/20.
//  Copyright © 2020 Khalil Najjar. All rights reserved.
//

import UIKit

class CaptionTextView: UITextView {
    
    //MARK: - Properties
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .twitterWhite
        label.text = "What's happening?"
        return label
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        backgroundColor = .twitterBlack
        font = .systemFont(ofSize: 16)
        isScrollEnabled = false
        heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        addSubview(placeholderLabel)
        placeholderLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 4)
        
        NotificationCenter.default.addObserver(self, selector: #selector(hadnleInputChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    @objc func hadnleInputChange() {
        placeholderLabel.isHidden = !text.isEmpty
    }
}
