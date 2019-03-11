//
//  SignInViewController.swift
//  PresentNewVC
//
//  Created by Marlon David Ruiz Arroyave on 3/6/19.
//  Copyright © 2019 Eafit. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    // MARK: Outlets

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let whatIsYourNameVC = segue.destination as? WhatIsYourNameViewController, let username = sender as? String else {
            return
        }
        
        whatIsYourNameVC.username = username
    }

    // MARK: Actions

    @IBAction func signIn(_ sender: UIButton) {
        if let username = userTextField.text, !username.isEmpty, let password = passwordTextField.text, !password.isEmpty {
            if (username == K.TestUser.Username) && (password == K.TestUser.Password) {
                performSegue(withIdentifier: K.Segue.WhatIsYourName, sender: username)
            } else {
                let oKAction = UIAlertAction(title: K.AlertLogin.OKActionTitle, style: .default, handler: nil)
                UIAlertController.presentAlert(title:  K.AlertLogin.Title, message: K.AlertLogin.MessageForNotLogin, actions: [oKAction], fromController: self)
            }
        } else {
            let oKAction = UIAlertAction(title: K.AlertLogin.OKActionTitle, style: .default, handler: nil)
            UIAlertController.presentAlert(title:  K.AlertLogin.Title, message: K.AlertLogin.Message, actions: [oKAction], fromController: self)
        }
    }

}
