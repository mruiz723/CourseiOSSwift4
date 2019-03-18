//
//  SignOutViewController.swift
//  Moments
//
//  Created by Marlon David Ruiz Arroyave on 3/11/19.
//  Copyright © 2019 Eafit. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol SignOutViewControllerDelegate: class {
    func userDidSignOut(userManager: UserManager)
}

class SignOutViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Properties

    weak var delegate: SignOutViewControllerDelegate?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        activityIndicator.isHidden = true
    }

    // MARK: - Actions

    @IBAction func signOut(_ sender: Any) {
        activityIndicator.show()
        guard let email = emailTextField.text, email.count > 0, let password = passwordTextField.text,
            password.count > 0, let rPassword = repeatPasswordTextField.text,
            rPassword.count > 0, password == rPassword  else {
            self.activityIndicator.dismiss()
            activityIndicator.dismiss()
            let oKAction = UIAlertAction(title: K.Action.okActionTitle, style: .default, handler: nil)
            UIAlertController.presentAlert(title: K.AlertTitle.signOut, message: K.Message.allFieldsAreRequired,
                                           actions: [oKAction], fromController: self)
            return
        }

        let userManager =  UserManager(email: email, password: password)

        DispatchQueue.global(qos: .userInteractive).async {
            userManager.signOut { [unowned self] (response) in
                DispatchQueue.main.async {
                    self.activityIndicator.dismiss()

                    guard response["user"] as? UserManager != nil else {
                        let oKAction = UIAlertAction(title: K.Action.okActionTitle, style: .default, handler: nil)
                        let message = response["error"] as? Error != nil
                                        ? (response["error"] as? Error)?.localizedDescription
                                        : K.Message.someWentWrong
                        UIAlertController.presentAlert(title: K.AlertTitle.signOut, message: message!,
                                                       actions: [oKAction], fromController: self)
                        return
                    }

                    self.delegate?.userDidSignOut(userManager: userManager)
                }
            }
        }
    }

    // MARK: - Actions

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
