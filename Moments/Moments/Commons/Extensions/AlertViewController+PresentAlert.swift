//
//  AlertViewController+PresentAlert.swift
//  PresentNewVC
//
//  Created by Marlon David Ruiz Arroyave on 3/6/19.
//  Copyright © 2019 Eafit. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    static func presentAlert(title: String, message: String,
                             actions: [UIAlertAction],
                             fromController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        for action in actions {
            alertController.addAction(action)
        }

        fromController.present(alertController, animated: true, completion: nil)
    }
}
