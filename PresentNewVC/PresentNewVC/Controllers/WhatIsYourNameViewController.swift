//
//  WhatIsYourNameViewController.swift
//  PresentNewVC
//
//  Created by Marlon David Ruiz Arroyave on 3/6/19.
//  Copyright © 2019 Eafit. All rights reserved.
//

import UIKit

class WhatIsYourNameViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!


    // MARK: - Properties

    var username: String?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        setupViews()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        nameTextField.text = ""
    }

    // MARK: - Navigation

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return !(nameTextField.text?.isEmpty)!
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        switch segue.identifier {
        case K.Segue.PresentModally:
            guard let showVC = segue.destination as? ModallyViewController else {
                return
            }
            showVC.name = nameTextField.text!
        case K.Segue.Show:
            guard let showVC = segue.destination as? ShowViewController else {
                return
            }
            showVC.name = nameTextField.text!
        default:
            return
        }

    }

    // MARK: - Public Methods

    func setupViews() {
        guard let username = username else {
            return
        }
        usernameLabel.text = "Welcome username: \(username)"
    }

}
