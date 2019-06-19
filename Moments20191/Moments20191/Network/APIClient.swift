//
//  APIClient.swift
//  Moments20191
//
//  Created by Usuario invitado on 18/6/19.
//  Copyright © 2019 eafit. All rights reserved.
//

import Foundation
import Alamofire
import FirebaseAuth

typealias CompletionHandler = ([String: Any]) -> Void

struct APIClient {
    
    static func signIn(email: String, password: String, completionHandler: @escaping CompletionHandler) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            guard let user = user else {
                completionHandler(["error": error ?? "Failed Sign in"])
                return
            }
            completionHandler(["user": user])
        }
    }
    
    static func signOut(email: String, password: String, completionHandler: @escaping CompletionHandler) {
        Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
            guard let authDataResult = authDataResult else {
                completionHandler(["error": error ?? "Failed create new user"])
                return
            }
            
            let user = authDataResult.user
            completionHandler(["user": user])
        }
    }
    
}
