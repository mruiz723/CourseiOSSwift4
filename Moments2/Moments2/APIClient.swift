//
//  APIClient.swift
//  Moments2
//
//  Created by Marlon David Ruiz Arroyave on 12/12/19.
//  Copyright © 2019 Usuario invitado. All rights reserved.
//

import Foundation
import Alamofire
import Firebase

typealias CompletionHandler = ([String: Any]) -> Void

struct APIClient {

    static func SignIn(email: String, password: String, completionHandler: @escaping CompletionHandler) {
        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
            guard let authDataResult = authDataResult else {
                completionHandler([K.error: error ?? K.Error.failedSignIn])
                return
            }
            completionHandler([K.user: authDataResult.user])
        }
    }

    static func SignOut(email: String, password: String, completionHandler: @escaping CompletionHandler) {
        Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
            guard let authDataResult = authDataResult else {
                completionHandler([K.error: error ?? K.Error.failedSignIn])
                return
            }
            completionHandler([K.user: authDataResult.user])
        }
    }

    static func newMoment(params: [String: Any], accessToken: String, completionHandler: @escaping CompletionHandler) {
        let URL = "\(K.ProductionServer.baseURL)\(K.ProductionServer.moments)\(K.json)?\(K.APIParameterKey.auth)=\(accessToken)"
        Alamofire.request(URL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: [:]).validate().responseJSON { response in
            guard response.result.isSuccess else {
                completionHandler([K.error: response.error ?? K.Message.someWentWrong])
                return
            }

            guard let value = response.result.value as? [String: Any] else {
                completionHandler([K.error: K.Error.malformedResponse])
                return
            }

            completionHandler([K.moment: value])
        }
    }

    static func moments(token: String, completionHandler: @escaping CompletionHandler) {
        let defaultSession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?

        guard let urlComponents = URLComponents(string: "\(K.ProductionServer.baseURL)\(K.ProductionServer.moments).\(K.json)"), let url = urlComponents.url else {
            completionHandler([K.error: K.Message.someWentWrong])
            return
        }

        dataTask = defaultSession.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler([K.error: K.Message.someWentWrong])
                return
            }

            do {
                guard let moments = try JSONSerialization.jsonObject(with: data, options: [] ) as? [String: Any] else {
                    completionHandler([K.error: K.Error.malformedResponse])
                    return
                }

                completionHandler([K.moments: moments])
            } catch let error as NSError {
                completionHandler([K.error: error])
            }
        })

        dataTask?.resume()

    }

}
