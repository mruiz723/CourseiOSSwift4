//
//  MomentViewController.swift
//  Moments20191
//
//  Created by Usuario invitado on 13/6/19.
//  Copyright © 2019 eafit. All rights reserved.
//

import UIKit

class MomentViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var momentImageView: UIImageView!
    @IBOutlet weak var momentTextView: UITextView!
    
    // MARK: - IBActions
    
    @IBAction func deleteMoment(_ sender: Any) {
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
