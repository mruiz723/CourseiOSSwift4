//
//  SignInViewController.swift
//  Moments
//
//  Created by Marlon David Ruiz Arroyave on 3/11/19.
//  Copyright © 2019 Eafit. All rights reserved.
//

import UIKit
import SVProgressHUD

class SignInViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        activityIndicator.isHidden = true
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        switch segue.identifier {
        case K.Segue.signOut:
            guard let signOutVC = segue.destination as? SignOutViewController else {
                return
            }
            signOutVC.delegate = self
        case K.Segue.moments:
            guard let momentsTableVC = segue.destination as? MomentsTableViewController, let userManager = sender as? UserManager else {
                return
            }
            momentsTableVC.userManager = userManager
        default:
            return
        }
    }

    // MARK: - Actions

    @IBAction func signIn(_ sender: Any) {
        activityIndicator.show()
        guard let email = usernameTextField.text, email.count > 0, let password = passwordTextField.text, password.count > 0  else {
            activityIndicator.dismiss()
            let oKAction = UIAlertAction(title: K.Action.okActionTitle, style: .default, handler: nil)
            UIAlertController.presentAlert(title: K.AlertTitle.signIn, message: K.Message.allFieldsAreRequired, actions: [oKAction], fromController: self)
            return
        }

        let userManager =  UserManager(email:email, password: password)

        DispatchQueue.global(qos: .userInteractive).async {
            userManager.signIn {  [unowned self] (response) in
                DispatchQueue.main.async {
                    self.activityIndicator.dismiss()

                    guard let _ = response["user"] as? UserManager else {
                        let oKAction = UIAlertAction(title: K.Action.okActionTitle, style: .default, handler: nil)
                        let message = response["error"] as? Error != nil ? (response["error"] as? Error)?.localizedDescription : K.Message.someWentWrong
                        UIAlertController.presentAlert(title: K.AlertTitle.signIn, message: message!, actions: [oKAction], fromController: self)
                        return
                    }

                    self.performSegue(withIdentifier: K.Segue.moments, sender: userManager)
                }
            }
        }
    }

}

extension SignInViewController: SignOutViewControllerDelegate {
    func userDidSignOut(userManager: UserManager) {
        performSegue(withIdentifier: K.Segue.moments, sender: userManager)
    }
}
