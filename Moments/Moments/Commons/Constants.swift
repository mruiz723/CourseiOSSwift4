//
//  Constants.swift
//  Moments
//
//  Created by Marlon David Ruiz Arroyave on 3/13/19.
//  Copyright © 2019 Eafit. All rights reserved.
//

import Foundation

struct K {

    // MARK: - Generics
    static let json = "json"

    // MARK: - Segue

    struct Segue {
        static let signOut = "SignOut"
        static let moments = "Moments"
        static let moment = "Moment"
        static let newMoment = "NewMoment"
    }

    // MARK: - CellIdentifier

    struct CellIdentifier {
        static let moment = "momentCell"
    }

    // MARK: - ProductionServer

    struct ProductionServer {
        static let baseURL = "https://moments-ef2e4.firebaseio.com/"
        static let moments = "moments"
    }

    // MARK: - APIParameterKey

    struct APIParameterKey {
        static let password = "password"
        static let email = "email"
        static let auth = "auth"
        static let title = "title"
        static let date = "date"
        static let imagePath = "imagePath"
        static let descriptionMoment = "descriptionMoment"
        static let createdBy = "createdBy"
        static let token = "auth"
        static let id = "id"
    }

    // MARK: - AlertTitle

    struct AlertTitle {
        static let signOut = "Sign Out"
        static let signIn = "Sign In"
        static let createMoment = "Create Moment"
        static let moment = "Moment"

    }

    // MARK: - Action

    struct Action {
        static let okActionTitle = "OK"
        static let yesActionTitle = "YES"
        static let noActionTitle = "NO"
    }

    // MARK: - Message

    struct Message {
        static let someWentWrong = "Something went wrong. Try again!"
        static let allFieldsAreRequired = "All fields are required!"
        static let messageDeleteMoment = "Are you sure that you want to delete"
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
