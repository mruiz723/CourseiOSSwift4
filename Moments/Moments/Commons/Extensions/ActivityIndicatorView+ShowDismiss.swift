//
//  ActivityIndicatorView+ShowDismiss.swift
//  Moments
//
//  Created by Marlon David Ruiz Arroyave on 3/15/19.
//  Copyright © 2019 Eafit. All rights reserved.
//

import Foundation
import UIKit

extension UIActivityIndicatorView {
    func show() {
        self.startAnimating()
        self.isHidden = false
    }

    func dismiss() {
        self.isHidden = true
        self.stopAnimating()
    }
}
