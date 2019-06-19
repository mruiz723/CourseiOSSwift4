//
//  SignInViewController.swift
//  Moments20191
//
//  Created by Usuario invitado on 13/6/19.
//  Copyright © 2019 eafit. All rights reserved.
//

import UIKit
import SVProgressHUD


class SignInViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - IBActions
    
    @IBAction func signIn(_ sender: Any) {
        SVProgressHUD.show()
        
        guard let email = userTextField.text, email.count > 0,
            let password = passwordTextField.text, password.count > 0 else {
                
                let okAction = UIAlertAction(title: K.AlertAction.okActionTitle, style: .default, handler: nil)
                UIAlertController.presentAlert(title: K.AlertTitle.signIn, message: K.Message.allFieldsAreRequired, actions: [okAction], fromController: self)
                return
        }
        
        let userManager = UserManager(email: email, password: password)
        
        userManager.signIn { (response) in
            SVProgressHUD.dismiss()
            guard response["user"] != nil else {
                let okAction = UIAlertAction(title: K.AlertAction.okActionTitle, style: .default, handler: nil)
                UIAlertController.presentAlert(title: K.AlertTitle.signIn, message: K.Message.someWentWrong, actions: [okAction], fromController: self)
                return
            }
            
            self.performSegue(withIdentifier: K.Segue.moments, sender: userManager)
        }
        
    }
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
            guard let momentsTableVC = segue.destination as? MomentsTableViewController else {
                return
            }
            momentsTableVC.userManager = sender as? UserManager
        default:
            return
        }
    }

}

extension SignInViewController: SignOutViewControllerDelegate {
    
    func userDidSignOut(userManager: UserManager) {
        performSegue(withIdentifier: K.Segue.moments, sender: userManager)
    }
    
}
