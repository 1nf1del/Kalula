//
//  FDUser.swift
//  Kalula
//
//  Created by Christopher Brandon Karani on 12/01/2018.
//  Copyright © 2018 Christopher Brandon Karani. All rights reserved.
//

import Foundation

protocol User {
    var profileImageUrl : String { get set }
    var userName        : String { get set }
    init(dictionary: [String: Any])
}

struct FDUser: User {
    var profileImageUrl: String
    
    var userName: String
    
    init(dictionary: [String : Any]) {
        profileImageUrl = dictionary["profileImageUrl"] as? String ?? "Error"
    }
}
