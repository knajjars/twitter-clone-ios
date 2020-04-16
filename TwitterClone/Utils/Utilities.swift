//
//  Utilities.swift
//  TwitterClone
//
//  Created by Khalil Najjar on 4/13/20.
//  Copyright © 2020 Khalil Najjar. All rights reserved.
//

import UIKit

class Utilities {
    func inputContainerView(image: UIImage, text: UITextField) -> UIView {
        let view = UIView()
        let iv = UIImageView()
        iv.image = image
        iv.setDimensions(width: 24, height: 24)
        
        // image
        view.addSubview(iv)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iv.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, paddingBottom: 8)
        
        // text field
        view.addSubview(text)
        text.anchor(left: iv.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, paddingBottom: 8)
        
        // divider
        let divider = UIView()
           divider.backgroundColor = .white
           view.addSubview(divider)
           divider.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, height: 0.75)
        
        return view
    }
    
    func textField(with placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.textColor = .white
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        return tf
    }
    
    func attributedButton(_ firstPart: String, _ secondPart: String) -> UIButton {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: firstPart, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white])
        
        attributedTitle.append(NSAttributedString(string: secondPart, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }
}
