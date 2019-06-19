//
//  SignOutViewController.swift
//  Moments20191
//
//  Created by Usuario invitado on 13/6/19.
//  Copyright © 2019 eafit. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol SignOutViewControllerDelegate: class {
    func userDidSignOut(userManager: UserManager)
}

class SignOutViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    weak var delegate: SignOutViewControllerDelegate?
    
    // MARK: - IBActions
    
    @IBAction func signOut(_ sender: Any) {
        SVProgressHUD.show()
        guard let email = emailTextField.text, email.count > 0,
            let password = passwordTextField.text, password.count >= 6,
            let rpassword = repeatPasswordTextField.text, rpassword.count >= 6,
            password == rpassword else {
                let okAction = UIAlertAction(title: K.AlertAction.okActionTitle, style: .default, handler: nil)
                UIAlertController.presentAlert(title: K.AlertTitle.signOut, message: K.Message.allFieldsAreRequired, actions: [okAction], fromController: self)
                SVProgressHUD.dismiss()
                return
        }
        
        let userManager = UserManager(email: email, password: password)
        
        userManager.signOut { [unowned self] (response) in
            guard response["user"] as? UserManager != nil else {
                let okAction = UIAlertAction(title: K.AlertAction.okActionTitle, style: .default, handler: nil)
                let message = response["error"] as? Error != nil ? response["error"] : K.Message.someWentWrong
                UIAlertController.presentAlert(title: K.AlertTitle.signOut, message: message as! String, actions: [okAction], fromController: self)
                SVProgressHUD.dismiss()
                return
            }
            
            SVProgressHUD.dismiss()
            
            self.delegate?.userDidSignOut(userManager: userManager)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                self.dismiss(animated: true, completion: nil)
            })
        }
        
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
