//
//  Moment.swift
//  Moments2
//
//  Created by Usuario invitado on 10/12/19.
//  Copyright © 2019 Usuario invitado. All rights reserved.
//

import Foundation

class Moment: NSObject {
    
    // MARK: Properties
    
    var idMoment: String
    var date: Date
    var title: String
    var imagePath: String
    var descriptionMoment: String
    var createdBy: String
    
    init(idMoment: String, date: Date, imagePath: String, descriptionMoment: String, createdBy: String, title: String) {
        self.idMoment = idMoment
        self.date = date
        self.title = title
        self.imagePath = imagePath
        self.descriptionMoment = descriptionMoment
        self.createdBy = createdBy
    }
    
    // MARK: - Class Methods

    static func newMoment(params: [String: Any],
                          accessToken: String,
                          completionHandler: @escaping CompletionHandler) {
        APIClient.newMoment(params: params, accessToken: accessToken) { (response) in
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

    static func moments(token: String,completionHandler: @escaping CompletionHandler) {
        APIClient.moments(token: token) { (response) in
            guard let data = response["moments"] as? [String: Any] else{
                completionHandler(response)
                return
            }

            var moments = [Moment]()

            for (key, value) in data {
                guard let item = value as? [String: Any] else {
                    completionHandler(response)
                    return
                }

                guard let timeStampString = item["date"] as? String,
                    let timeStamp = Double(timeStampString),
                    let title = item["title"] as? String,
                    let imagePath = item["imagePath"] as? String,
                    let descriptionMoment = item["descriptionMoment"] as? String,
                    let createdBy = item["createdBy"] as? String
                    else {
                        completionHandler(["error": "Malformed data received"])
                        return
                }

                let date = Date(timeIntervalSince1970: timeStamp)
                let moment = Moment(idMoment: key, date: date, imagePath: imagePath, descriptionMoment:descriptionMoment, createdBy: createdBy, title: title)
                moments.append(moment)
            }

            completionHandler(["moments": moments])
        }
    }
    
}
