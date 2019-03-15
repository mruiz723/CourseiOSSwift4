//
//  APIClient.swift
//  Moments
//
//  Created by Marlon David Ruiz Arroyave on 3/13/19.
//  Copyright © 2019 Eafit. All rights reserved.
//

import Foundation
import Alamofire
import FirebaseAuth

typealias completionHandler = ([String: Any?]) -> Void

struct APIClient {
    static func signOut(email: String, password: String, completionHandler: @escaping completionHandler) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user else {
                completionHandler(["error": error ?? "Failed create new user"])
                return
            }
            completionHandler(["user": user])
        }
    }

    static func signIn(email: String, password: String, completionHandler: @escaping completionHandler) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            guard let user = user else {
                completionHandler(["error": error ?? "Failed create new user"])
                return
            }
            completionHandler(["user": user])
        }
    }

}
