//
//  Moment.swift
//  Moments
//
//  Created by Marlon David Ruiz Arroyave on 3/13/19.
//  Copyright © 2019 Eafit. All rights reserved.
//

import Foundation

let response = [
    [
        "date": "01 Jul 2018",
        "title": "En la Clase iOS",
        "imagePath": "moments",
        "descriptionMoment": "En la clase pasando bueno!",
        "createdBy": "mruiz723@gmail.com"
    ],

    [
        "date": "07 Jul 2018",
        "title": "En la Clase iOS 1",
        "imagePath": "moments",
        "descriptionMoment": "En la clase pasando bueno!",
        "createdBy": "mruiz723@gmail.com"
    ],

    [
        "date": "21 Jul 2018",
        "title": "En la Clase iOS 2",
        "imagePath": "moments",
        "descriptionMoment": "En la clase pasando bueno!",
        "createdBy": "mruiz723@gmail.com"
    ]
]

class Moment: NSObject {

    // MARK: Properties

    var idMoment: String
    var date: Date
    var title: String
    var imagePath: String
    var descriptionMoment: String
    var createdBy: String

    // MARK: Init

    init(idMoment: String, date: Date, title: String, imagePath: String, descriptionMoment: String, createdBy: String) {
        self.idMoment = idMoment
        self.date = date
        self.title = title
        self.imagePath = imagePath
        self.descriptionMoment = descriptionMoment
        self.createdBy = createdBy
    }

    static func newMoment(params: [String: Any],
                          accessToken: String,
                          completionHandler: @escaping CompletionHandler) {
        APIClient.newMoment(params: params, accessToken: accessToken) { response in
            completionHandler(response)
        }
    }

    static func deleteMoment(idMoment: String,
                             accessToken: String,
                             completionHandler: @escaping CompletionHandler) {
        APIClient.deleteMoment(idMoment: idMoment, accessToken: accessToken) { response in
            completionHandler(response)
        }
    }

    static func moments(token: String, completionHandler: @escaping CompletionHandler) {
        APIClient.moments(token: token) { response in
            guard let data = response["moments"] as? [String: Any] else {
                completionHandler(response)
                return
            }

            var moments = [Moment]()

            for (key, value) in data {
                print("key: \(key), value\(value)\n")
                guard let item = value as? [String: Any] else {
                    completionHandler(response)
                    return
                }

                guard let timestampString = item["date"] as? String,
                    let timestamp = Double(timestampString),
                    let title = item["title"] as? String,
                    let imagePath = item["imagePath"] as? String,
                    let descriptionMoment = item["descriptionMoment"] as? String,
                    let createdBy = item["createdBy"] as? String else {
                        completionHandler(["error": "Malformed data received"])
                        return
                }

                let date = NSDate(timeIntervalSince1970: timestamp)
                let moment = Moment(idMoment: key, date: date as Date, title: title, imagePath: imagePath,
                                    descriptionMoment: descriptionMoment, createdBy: createdBy)
                moments.append(moment)
            }

            completionHandler(["moments": moments])
        }
    }
}
