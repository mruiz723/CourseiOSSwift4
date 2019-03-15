//
//  MomentViewController.swift
//  Moments
//
//  Created by Marlon David Ruiz Arroyave on 3/13/19.
//  Copyright © 2019 Eafit. All rights reserved.
//

import UIKit

class MomentViewController: UIViewController {

    // MARK: - Properties

    var moment: Moment?

    // MARK: - Outlets

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var momentImageView: UIImageView!
    @IBOutlet weak var momentTextView: UITextView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Public Methods

    func setupViews() {
        guard let moment = moment else {
            return
        }

        dateLabel.text = moment.date.stringFromDate()
        titleLabel.text = moment.title
        momentImageView.image = UIImage(named: moment.imageURLString)
    }

    // MARK: - Actions

    @IBAction func deleteMoment(_ sender: Any) {

    }


}
