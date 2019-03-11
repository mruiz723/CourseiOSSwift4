//
//  ModallyViewController.swift
//  PresentNewVC
//
//  Created by Marlon David Ruiz Arroyave on 3/6/19.
//  Copyright © 2019 Eafit. All rights reserved.
//

import UIKit

class ModallyViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var greetingsLabel: UILabel!
    @IBOutlet weak var navBar: UINavigationBar!

    // MARK: Properties
    var name: String?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
    }

    func setupViews() {
        guard let name = name else {
            return
        }

        let navigationItem = navBar.items?.first
        navigationItem?.title = name
        greetingsLabel.text = "Welcome \(name)! This is the way to present modally a scene!"
    }

    // MARK: Actions

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
