//
//  Moment.swift
//  Moments
//
//  Created by Marlon David Ruiz Arroyave on 3/13/19.
//  Copyright © 2019 Eafit. All rights reserved.
//

import Foundation

typealias momentCompletionHandler = ([Moment]) -> ()

let response = [
    [
        "date": "01 Jul 2018",
        "title": "En la Clase iOS",
        "imageURLString": "moments",
        "descriptionMoment": "En la clase pasando bueno!",
        "createdBy": "mruiz723@gmail.com"
    ],

    [
        "date": "07 Jul 2018",
        "title": "En la Clase iOS 1",
        "imageURLString": "moments",
        "descriptionMoment": "En la clase pasando bueno!",
        "createdBy": "mruiz723@gmail.com"
    ],

    [
        "date": "21 Jul 2018",
        "title": "En la Clase iOS 2",
        "imageURLString": "moments",
        "descriptionMoment": "En la clase pasando bueno!",
        "createdBy": "mruiz723@gmail.com"
    ],
]

class Moment: NSObject {

    // MARK: Properties

    var date: Date
    var title: String
    var imageURLString: String
    var descriptionMoment: String
    var createdBy: String


    // MARK: Init

    init(date: Date, title: String, imageURLString: String, descriptionMoment: String, createdBy: String) {
        self.date = date
        self.title = title
        self.imageURLString = imageURLString
        self.descriptionMoment = descriptionMoment
        self.createdBy = createdBy
    }

    static func moments(completion: momentCompletionHandler) {

        var moments = [Moment]()
        for item in response {
            let moment = Moment(date: Date(), title: item["title"]!, imageURLString: item["imageURLString"]!, descriptionMoment: item["descriptionMoment"]!, createdBy: item["createdBy"]!)
            moments.append(moment)
        }

        completion(moments)
    }
}
