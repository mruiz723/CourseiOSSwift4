//
//  SignUpViewController.swift
//  Moments2
//
//  Created by Usuario invitado on 10/12/19.
//  Copyright © 2019 Usuario invitado. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol SignUpViewControllerDelegate: class {
    func userDidSignUp(userManager: UserManager)
}

class SignUpViewController: UIViewController {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!

    // MARK: - Properties
    weak var delegate: SignUpViewControllerDelegate?
    
    //MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: IBActions
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func signUp(_ sender: Any) {
        SVProgressHUD.show()
        guard let email = emailTextField.text, email.count > 0,
            let password = passwordTextField.text, password.count >= 6,
            let rpassword = repeatPasswordTextField.text, rpassword.count >= 6,
            password == rpassword else {
                let okAction = UIAlertAction(title: K.AlertAction.okActionTitle, style: .default, handler: nil)
                UIAlertController.presentAlert(title: K.AlertTitle.signUp, message: K.Message.allFieldsAreRequired, actions: [okAction], fromController: self)
                SVProgressHUD.dismiss()
                return
        }

        UserManager.signUp(email: email, password: password) { response in
            SVProgressHUD.dismiss()

            guard let userManager = response[K.user] as? UserManager else {
                let okAction = UIAlertAction(title: K.AlertAction.okActionTitle, style: .default, handler: nil)
                let message = response[K.error] as? String ?? K.Message.someWentWrong
                UIAlertController.presentAlert(title: K.AlertTitle.signUp, message: message, actions: [okAction], fromController: self)
                return
            }

            self.delegate?.userDidSignUp(userManager: userManager)
            self.dismiss(animated: true, completion: nil)
        }
    }
}
