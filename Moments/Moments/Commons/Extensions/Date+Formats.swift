//
//  Date+Formats.swift
//  Moments
//
//  Created by Marlon David Ruiz Arroyave on 3/15/19.
//  Copyright © 2019 Eafit. All rights reserved.
//

import Foundation

extension Date {
    func stringFromDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: self)
    }

}
