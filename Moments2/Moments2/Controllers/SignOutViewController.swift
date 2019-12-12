//
//  SignOutViewController.swift
//  Moments2
//
//  Created by Usuario invitado on 10/12/19.
//  Copyright © 2019 Usuario invitado. All rights reserved.
//

import UIKit

class SignOutViewController: UIViewController {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    //MARK: LifeCycle

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
    
    //MARK: IBActions
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func signOut(_ sender: Any) {

    }
}
