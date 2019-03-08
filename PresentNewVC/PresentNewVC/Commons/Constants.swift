//
//  Constants.swift
//  PresentNewVC
//
//  Created by Marlon David Ruiz Arroyave on 3/6/19.
//  Copyright © 2019 Eafit. All rights reserved.
//

import Foundation

struct K {
    struct TestUser {
        static let Username = "mruiz"
        static let Password = "swift"
    }

    struct AlertLogin {
        static let Title = "Login"
        static let Message =  "Both fields are required!"
        static let MessageForNotLogin =  "The user or password is incorrect, try again!"
        static let OKActionTitle = "OK"
    }

    struct Segue {
        static let WhatIsYourName = "WhatIsYourName"
        static let Show = "Show"
        static let PresentModally = "PresentModally"
    }

}
