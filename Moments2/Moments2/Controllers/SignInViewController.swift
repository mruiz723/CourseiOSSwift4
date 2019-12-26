//
//  SignInViewController.swift
//  Moments2
//
//  Created by Usuario invitado on 10/12/19.
//  Copyright © 2019 Usuario invitado. All rights reserved.
//

import UIKit
import SVProgressHUD

class SignInViewController: UIViewController {
    
    //MARK: IBOutlets

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case K.Segue.signUp:
            guard let signUpVC = segue.destination as? SignUpViewController else {
                return
            }
            signUpVC.delegate = self
        case K.Segue.moments:
            guard let momentsTableVC = segue.destination as? MomentsTableViewController else {
                return
            }
            momentsTableVC.userManager = sender as? UserManager
        default:
            break
        }

    }
    
    //MARK: IBActions
    
    @IBAction func signIn(_ sender: Any) {
        SVProgressHUD.show()
        guard let email = usernameTextField.text, email.count > 0,
            let password = passwordTextField.text, password.count > 0 else {
                let okAction = UIAlertAction(title: K.AlertAction.okActionTitle, style: .default, handler: nil)
                UIAlertController.presentAlert(title: K.AlertTitle.signIn, message: K.Message.allFieldsAreRequired, actions: [okAction], fromController: self)
                return
        }

        UserManager.signIn(email: email, password: password) { response in
            SVProgressHUD.dismiss()
            guard let userManager = response[K.user] as? UserManager else {
                let error = (response[K.error] as? NSError)?.localizedDescription ?? K.Message.someWentWrong
                let okAction = UIAlertAction(title: K.AlertAction.okActionTitle, style: .default, handler: nil)
                UIAlertController.presentAlert(title: K.AlertTitle.signIn, message: error, actions: [okAction], fromController: self)
                return
            }

            self.performSegue(withIdentifier: K.Segue.moments, sender: userManager)
        }
    }
}

extension SignInViewController: SignUpViewControllerDelegate {
    func userDidSignUp(userManager: UserManager) {
        performSegue(withIdentifier: K.Segue.moments, sender: userManager)
    }
}
