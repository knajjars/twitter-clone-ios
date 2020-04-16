//
//  LoginController.swift
//  TwitterClone
//
//  Created by Khalil Najjar on 4/13/20.
//  Copyright © 2020 Khalil Najjar. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    //MARK: - Properties
    private let logoImage: UIImageView = {
        let iv = UIImageView()
        
        iv.image = #imageLiteral(resourceName: "TwitterLogo")
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        
        return iv
    }()
    
    private let emailTextField: UITextField = {
        let tf = Utilities().textField(with: "Email")
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utilities().textField(with: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.twitterBlue, for: .normal)
        button.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        return button
    }()
    
    
    private lazy var emailContainerView: UIView = {
        let view = Utilities().inputContainerView(image: #imageLiteral(resourceName: "mail_unselected"), text: emailTextField)
        
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = Utilities().inputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), text: passwordTextField)
        
        return view
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Don't have an account?", " Sign Up")
        
        button.addTarget(self, action: #selector(handlShowSignUp), for: .touchUpInside)
        
        return button
    }()
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    
    @objc func handleLogin() {
        print("Login here...")
    }
    
    @objc func handlShowSignUp() {
        let controller = RegistrationController()
        
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    //MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        
        // add logo
        view.addSubview(logoImage)
        logoImage.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logoImage.setDimensions(width: 150, height: 150)
        
        // add form stack
        let stack = UIStackView(arrangedSubviews: [
            emailContainerView,
            passwordContainerView,
            loginButton
        ])
        
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: logoImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 24, paddingRight: 24)
        
        // don't have account
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor)
    }
}
