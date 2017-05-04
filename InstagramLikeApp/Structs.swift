//
//  Structs.swift
//  InstagramLikeApp
//
//  Created by eric yu on 4/9/17.
//  Copyright © 2017 eric yu. All rights reserved.
//

import Foundation


struct User {
    let username: String
    let profileImageUrl: String
    
    init(dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"]  as? String ?? ""
    }
}
