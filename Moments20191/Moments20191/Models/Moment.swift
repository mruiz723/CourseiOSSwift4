//
//  Moment.swift
//  Moments20191
//
//  Created by Usuario invitado on 20/6/19.
//  Copyright © 2019 eafit. All rights reserved.
//

import Foundation

class Moment: NSObject {
    
     // MARK: - Properties
    var idMoment: String
    var date: Date
    var title: String
    var imagePath: String
    var descriptionMoment: String
    var createBy: String
    
     // MARK: - Init
    
    init(idMoment: String, date: Date, title: String, imagePath: String, descriptionMoment: String, createBy: String) {
        self.idMoment = idMoment
        self.date = date
        self.title = title
        self.imagePath = imagePath
        self.descriptionMoment = descriptionMoment
        self.createBy = createBy
    }
    
    
     // MARK: - Class Methods
    
    static func newMoment(params: [String: Any],
                          accessToken: String,
                          completionHandler: @escaping CompletionHandler) {
        APIClient.newMoment(params: params, accessToken: accessToken) { (response) in
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
                let moment = Moment(idMoment: key, date: date, title: title, imagePath: imagePath, descriptionMoment: descriptionMoment, createBy: createdBy)
                moments.append(moment)
            }
            
            completionHandler(["moments": moments])
        }
    }
    
}
