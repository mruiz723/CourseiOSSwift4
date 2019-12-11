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
    
    func createMoment() {
        
    }
    
    func moments(){
        
    }
    
    func deleteMoment() {
        
    }
    
    func updateMoment() {
        
    }
    
}
