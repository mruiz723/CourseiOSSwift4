//
//  NewMomentViewController.swift
//  Moments20191
//
//  Created by Usuario invitado on 13/6/19.
//  Copyright © 2019 eafit. All rights reserved.
//

import UIKit

class NewMomentViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var titleTextView: UITextField!
    @IBOutlet weak var momentImageView: UIImageView!
    @IBOutlet weak var momentTextView: UITextView!
    
    // MARK: - IBActions
    
    @IBAction func createMoment(_ sender: Any) {
    }
    
    @IBAction func camera(_ sender: Any) {
    }
    
    @IBAction func photoLibrary(_ sender: Any) {
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
