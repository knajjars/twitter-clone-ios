//
//  AuthService.swift
//  TwitterClone
//
//  Created by Khalil Najjar on 4/18/20.
//  Copyright © 2020 Khalil Najjar. All rights reserved.
//

import Foundation
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let fullName: String
    let userName: String
    let prfofileImage: UIImage
}

struct AuthService {
    static let shared = AuthService()
    
    func loginUser(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func registerUser(credentials: AuthCredentials, completion: @escaping(Error?, DatabaseReference) -> Void) {
        let email = credentials.email
        let password = credentials.password
        let fullName = credentials.fullName
        let userName = credentials.userName
        let profileImage = credentials.prfofileImage
        
        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else {return}
        let imageName = NSUUID().uuidString
        
        let profileImageRef = PROFILE_IMAGE_REF.child(imageName)
        
        profileImageRef.putData(imageData, metadata: nil) { (metadata, error) in
            
            profileImageRef.downloadURL { (url, err) in
                guard let profileImageURL = url?.absoluteString else {return}
                
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if let err = error {
                        print(err.localizedDescription)
                        return
                    }
                    
                    let values = [
                        "email": email,
                        "userName": userName,
                        "fullName": fullName,
                        "profileImageURL": profileImageURL
                    ]
                    
                    guard let uid = result?.user.uid else {return}
                    let userRef = USER_REF.child(uid)
                    
                    userRef.updateChildValues(values, withCompletionBlock: completion)
                }
            }
        }
    }
}
