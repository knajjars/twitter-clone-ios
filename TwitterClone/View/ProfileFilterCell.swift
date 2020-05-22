//
//  ProfileFilterCell.swift
//  TwitterClone
//
//  Created by Khalil Najjar on 5/18/20.
//  Copyright © 2020 Khalil Najjar. All rights reserved.
//

import UIKit

class ProfileFilterCell: UICollectionViewCell {
    //MARK: - Properties
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .twitterWhite
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "TEST"
        return label
    }()
    
    //MARK: - Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .twitterBlack
        
        addSubview(titleLabel)
        titleLabel.center(inView: self)
    }
    
    override var isSelected: Bool {
        didSet {
            titleLabel.font = isSelected
                ? UIFont.boldSystemFont(ofSize: 16)
                : UIFont.systemFont(ofSize: 14)
            titleLabel.textColor = isSelected
                ? .twitterBlue
                : .twitterWhite
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
