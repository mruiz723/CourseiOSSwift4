//
//  Date+Formats.swift
//  Moments20191
//
//  Created by Usuario invitado on 18/6/19.
//  Copyright © 2019 eafit. All rights reserved.
//

import Foundation

extension Date {
    
    func stringFromDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: self)
    }
    
}

