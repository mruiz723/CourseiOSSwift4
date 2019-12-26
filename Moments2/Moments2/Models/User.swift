//
//  User.swift
//  Moments2
//
//  Created by Usuario invitado on 10/12/19.
//  Copyright © 2019 Usuario invitado. All rights reserved.
//

import Foundation
import FirebaseAuth

class UserManager: NSObject {
    
    // MARK: - Properties
    
    var email: String
    var password: String
    var user: User?
    
    // MARK: - Init
    
    init(email: String, password: String, user: User? = nil) {
        self.email = email
        self.password = password
        self.user = user
    }
    
    static func signIn(email: String, password: String, completionHandler: @escaping CompletionHandler) {
        APIClient.signIn(email: email, password: password) { (response) in
            guard let user = response[K.user] as? User else {
                completionHandler(response)
                return
            }

            let userManager = UserManager(email: email, password: password, user: user)
            completionHandler([K.user: userManager])
        }
    }
    
    static func signUp(email: String, password: String, completionHandler: @escaping CompletionHandler) {
        APIClient.signUp(email: email, password: password) { response in
            guard let user = response[K.user] as? User else {
                completionHandler(response)
                return
            }

            let userManager = UserManager(email: email, password: password, user: user)
            completionHandler([K.user: userManager])
        }
    }
    
}
