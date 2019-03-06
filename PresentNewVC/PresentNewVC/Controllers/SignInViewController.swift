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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: Actions

    @IBAction func signIn(_ sender: UIButton) {

    }

}
