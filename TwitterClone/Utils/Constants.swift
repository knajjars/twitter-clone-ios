//
//  Constants.swift
//  
//
//  Created by Khalil Najjar on 4/17/20.
//

import Firebase

let STORAGE_REF = Storage.storage().reference()
let PROFILE_IMAGE_REF = STORAGE_REF.child("profile_images")

let DB_REF = Database.database().reference()
let USER_REF = DB_REF.child("users")
let TWEET_REF = DB_REF.child("tweets")
