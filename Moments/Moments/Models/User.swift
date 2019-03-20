//
//  User.swift
//  Moments
//
//  Created by Marlon David Ruiz Arroyave on 3/13/19.
//  Copyright © 2019 Eafit. All rights reserved.
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

    // MARK: - Class Methods

    func signOut(completionHandler: @escaping CompletionHandler) {
        APIClient.signOut(email: self.email, password: self.password) { [unowned self] response in
            guard let user = response["user"] as? User else {
                completionHandler(response)
                return
            }
            self.user = user
            completionHandler(["user": self])
        }
    }

    func signIn(completionHandler: @escaping CompletionHandler) {
        APIClient.signIn(email: self.email, password: self.password) { [unowned self] response in
            guard let authDataResult = response["user"] as? AuthDataResult else {
                completionHandler(response)
                return
            }
            self.user = authDataResult.user
            completionHandler(["user": self])
        }
    }

}