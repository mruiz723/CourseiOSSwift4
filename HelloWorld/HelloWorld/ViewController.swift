//
//  ViewController.swift
//  HelloWorld
//
//  Created by Marlon David Ruiz Arroyave on 3/4/19.
//  Copyright © 2019 Eafit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!


    @IBAction func greetings(_ sender: Any) {
        guard let name = nameTextField.text?.isEmpty else {
            return
        }
        nameLabel.text = "Hello world \(name)"
        nameLabel.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

