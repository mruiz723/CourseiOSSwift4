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
    
    static func newMoment(params: [String: Any], accessToken: String, completionHandler: @escaping CompletionHandler) {
        
        let URL = "\(K.ProductionServer.baseURL)\(K.ProductionServer.moments).\(K.json)?auth=\(accessToken)"
        Alamofire.request(URL, method: .post, parameters: params,
                          encoding: JSONEncoding.default,
                          headers: [:]).validate().responseJSON { response in
                            
                            guard response.result.isSuccess else {
                                completionHandler(["error": response.error ?? "Something went wrong"])
                                return
                            }
                            
                            guard let value = response.result.value as? [String: Any] else {
                                completionHandler(["error": "Malformed data received"])
                                return
                            }
                            
                            completionHandler(["moment": value])
        }
    }

    static func moments(token: String,completionHandler: @escaping CompletionHandler) {
        
        let defaultSession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?
        
        if var urlComponents = URLComponents(string: "\(K.ProductionServer.baseURL)\(K.ProductionServer.moments).\(K.json)") {
            urlComponents.query = "\(K.APIParameterKey.auth)=\(token)"
            
            guard let url = urlComponents.url else {
                return
            }
            
            dataTask = defaultSession.dataTask(with: url, completionHandler: { data, response, error in
                if let error = error {
                    completionHandler(["error": error])
                } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    do {
                        if let moments = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            completionHandler(["moments": moments])
                        }
                    } catch let error as NSError {
                       completionHandler(["error": error])
                    }
                }
                
            })
            
            dataTask?.resume()
        }
    }
    
    
}
