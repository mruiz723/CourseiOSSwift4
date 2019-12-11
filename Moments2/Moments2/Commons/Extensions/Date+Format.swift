//
//  Date+Format.swift
//  Moments2
//
//  Created by Usuario invitado on 10/12/19.
//  Copyright © 2019 Usuario invitado. All rights reserved.
//

import Foundation

extension Date {
    
    func stringFromDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: self)
    }
    
}
