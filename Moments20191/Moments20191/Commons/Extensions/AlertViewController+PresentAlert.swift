//
//  AlertViewController+PresentAlert.swift
//  Moments20191
//
//  Created by Usuario invitado on 18/6/19.
//  Copyright © 2019 eafit. All rights reserved.
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
