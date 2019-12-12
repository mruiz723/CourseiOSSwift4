//
//  Constants.swift
//  Moments2
//
//  Created by Usuario invitado on 10/12/19.
//  Copyright © 2019 Usuario invitado. All rights reserved.
//

import Foundation

struct K {
    
    // MARK: - Generics
    
    static let json = "json"
    static let moment = "moment"
    static let error = "error"
    static let user = "user"
    static let moments = "moments"
    
    // MARK: - Segues
    
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
        static let baseURL = "https://moments20192.firebaseio.com/"
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
        static let important = "IMPORTANT!"
    }
    
    // MARK: - AlertActions
    
    struct AlertAction {
        static let okActionTitle = "OK"
        static let yesActionTitle = "YES"
        static let noActionTitle = "NO"
    }
    
    // MARK: - Message
    
    struct Message {
        static let someWentWrong = "Something went wrong. Try Again!"
        static let allFieldsAreRequired = "All fields are required!"
        static let messageDeleteMoment = "Are you sure that you want to delete?"
        static let requiredCamera = "Camera access requiered for capturing photos"
    }

    struct Error {
        static let failedSignIn = "Failed Sign in"
        static let malformedResponse = "Malformed data received"
    }
}
