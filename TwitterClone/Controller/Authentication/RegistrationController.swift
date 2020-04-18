//
//  RegistrationController.swift
//  TwitterClone
//
//  Created by Khalil Najjar on 4/13/20.
//  Copyright © 2020 Khalil Najjar. All rights reserved.
//

import UIKit
import Firebase

class RegistrationController: UIViewController {
    
    //MARK: - Properties
    
    private var profileImage: UIImage?
    
    private let imagePicker = UIImagePickerController()
    
    private let addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleAddPhoto), for: .touchUpInside)
        
        return button
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
    
    private let fullNameTextField: UITextField = {
        let tf = Utilities().textField(with: "Full Name")
        return tf
    }()
    
    private let userNameTextField: UITextField = {
        let tf = Utilities().textField(with: "Username")
        return tf
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = Utilities().inputContainerView(image: #imageLiteral(resourceName: "mail_unselected"), text: emailTextField)
        
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = Utilities().inputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), text: passwordTextField)
        
        return view
    }()
    
    private lazy var fullNameContainerView: UIView = {
        let view = Utilities().inputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), text: fullNameTextField)
        
        return view
    }()
    
    private lazy var userNameContainerView: UIView = {
        let view = Utilities().inputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), text: userNameTextField)
        
        return view
    }()
    
    private let alreadyHaveAccount: UIButton = {
        let button = Utilities().attributedButton("Already have an account?", " Log In")
        
        button.addTarget(self, action: #selector(handlShowLogIn), for: .touchUpInside)
        
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.twitterBlue, for: .normal)
        button.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        
        return button
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        spinner.color = .twitterBlue
        return spinner
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
    
    //MARK: - Selectors
    
    @objc func handleAddPhoto() {
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @objc func handlShowLogIn() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSignUp() {
        guard let profileImage = profileImage else {return}
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let fullName = fullNameTextField.text else {return}
        guard let userName = userNameTextField.text else {return}
        
        let authCredentials = AuthCredentials(email: email, password: password, fullName: fullName, userName: userName, prfofileImage: profileImage)
        
        spinner.startAnimating()
        
        AuthService.shared.registerUser(credentials: authCredentials) { (error, ref) in
            self.spinner.stopAnimating()
            
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else {return}
            guard let nav = window.rootViewController as? MainTabController else {return}
            
            nav.authenticateUserAndConfigureUI()
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    //MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        
        // add button
        view.addSubview(addPhotoButton)
        addPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        addPhotoButton.setDimensions(width: 125, height: 125)
        
        // add spinner to button
        signUpButton.addSubview(spinner)
        spinner.anchor(top: signUpButton.topAnchor, bottom: signUpButton.bottomAnchor, right: signUpButton.rightAnchor, paddingRight: 16)
        
        
        // add form stack
        let stack = UIStackView(arrangedSubviews: [
            emailContainerView,
            passwordContainerView,
            fullNameContainerView,
            userNameContainerView,
            signUpButton
        ])
        
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: addPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 24, paddingRight: 24)
        
        // already have account
        
        view.addSubview(alreadyHaveAccount)
        alreadyHaveAccount.anchor(left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor)
    }
}

//MARK: - Extension UIImagePickerControllerDelegate

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let userImage = info[.editedImage] as? UIImage else { return }
        
        profileImage = userImage
        
        addPhotoButton.layer.cornerRadius = 128 / 2
        addPhotoButton.layer.masksToBounds = true
        addPhotoButton.imageView?.contentMode = .scaleAspectFill
        addPhotoButton.imageView?.clipsToBounds = true
        addPhotoButton.layer.borderColor = UIColor.white.cgColor
        addPhotoButton.layer.borderWidth = 3
        
        addPhotoButton.setImage(userImage.withRenderingMode(.alwaysOriginal),for: .normal)
        dismiss(animated: true, completion: nil)
    }
    
}
