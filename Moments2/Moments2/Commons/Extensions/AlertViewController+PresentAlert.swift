//
//  AlertViewController+PresentAlert.swift
//  Moments2
//
//  Created by Usuario invitado on 10/12/19.
//  Copyright © 2019 Usuario invitado. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    
    static func presentAlert(title: String,
                             message: String,
                             actions: [UIAlertAction],
                             fromController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for action in actions {
            alertController.addAction(action)
        }
        
        fromController.present(alertController, animated: true, completion: nil)
    }
    
}
