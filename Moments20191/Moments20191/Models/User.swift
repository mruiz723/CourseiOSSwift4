//
//  User.swift
//  Moments20191
//
//  Created by Usuario invitado on 18/6/19.
//  Copyright © 2019 eafit. All rights reserved.
//

import Foundation
import FirebaseAuth

class UserManager: NSObject {
    
    // MARK: - Properties
    
    var email: String
    var password: String
    var user: User?
    
    // MARK: - Init
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    func signIn(completionHandler: @escaping CompletionHandler) {
        APIClient.signIn(email: email, password: password) { [unowned self] (response) in
            guard let authDataResult = response["user"] as? AuthDataResult else {
                completionHandler(response)
                return
            }
            self.user = authDataResult.user
            completionHandler(["user": self])
        }
    }
    
    func signOut(completionHandler: @escaping CompletionHandler) {
        APIClient.signOut(email: email, password: password) { [unowned self] (response) in
            guard let user = response["user"] as? User else {
                completionHandler(response)
                return
            }
            self.user = user
            completionHandler(["user": self])
        }
    }
    
}
