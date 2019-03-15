//
//  Constants.swift
//  Moments
//
//  Created by Marlon David Ruiz Arroyave on 3/13/19.
//  Copyright © 2019 Eafit. All rights reserved.
//

import Foundation

struct K {
    struct Segue {
        static let signOut = "SignOut"
        static let moments = "Moments"
        static let moment = "Moment"
        static let NewMoment = "NewMoment"
    }

    struct CellIdentifier {
        static let moment = "momentCell"
    }

    struct ProductionServer {
        static let baseURL = "https://api.medium.com/v1"
        static let API_KEY = "AIzaSyCKCDt1Mw_hn5Qe-0BbxhYd9i3sL39yrfw"
    }

    struct APIParameterKey {
        static let password = "password"
        static let email = "email"
        static let nickname = "nickname"
    }

    struct AlertTitle {
        static let signOut = "Sign Out"
        static let signIn = "Sign Out"

    }

    struct Action {
        static let okActionTitle = "OK"
    }

    struct Message {
        static let someWentWrong = "Something went wrong. Try again!"
        static let allFieldsAreRequired = "All fields are required!"
    }

}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
