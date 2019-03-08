//
//  ShowViewController.swift
//  PresentNewVC
//
//  Created by Marlon David Ruiz Arroyave on 3/6/19.
//  Copyright © 2019 Eafit. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var greetingsLabel: UILabel!

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

        title = name
        greetingsLabel.text = "Welcome \(name)! This is the way to show a scene!"
    }

}
