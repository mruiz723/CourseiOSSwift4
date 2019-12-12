//
//  User.swift
//  Moments2
//
//  Created by Usuario invitado on 10/12/19.
//  Copyright © 2019 Usuario invitado. All rights reserved.
//

import Foundation

class UserManager: NSObject {
    
    // MARK: - Properties
    
    var email: String
    var password: String
    
    // MARK: - Init
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    func signIn(completionHandler: @escaping CompletionHandler) {
        
    }
    
    func signOut(completionHandler: @escaping CompletionHandler) {
        
    }
    
}
