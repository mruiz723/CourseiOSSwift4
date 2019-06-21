//
//  Constants.swift
//  Moments20191
//
//  Created by Usuario invitado on 18/6/19.
//  Copyright © 2019 eafit. All rights reserved.
//

import Foundation

struct K {
    
    // MARK: - Generics
    
    static let json = "json"
    
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
        static let baseURL = "https://moments-ad624.firebaseio.com/"
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
    
}
