//
//  User.swift
//  Moments2
//
//  Created by Usuario invitado on 10/12/19.
//  Copyright © 2019 Usuario invitado. All rights reserved.
//

import Foundation

class User: NSObject {
    
    // MARK: - Properties
    
    var user: String
    var password: String
    
    // MARK: - Init
    
    init(user: String, password: String) {
        self.user = user
        self.password = password
    }
    
    func signIn() {
        
    }
    
    func signOut() {
        
    }
    
}
