//
//  ExploreController.swift
//  TwitterClone
//
//  Created by Khalil Najjar on 4/12/20.
//  Copyright © 2020 Khalil Najjar. All rights reserved.
//

import UIKit

class ExploreController: UIViewController {
    
    //MARK: - Properties
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Explore"
    }
}
