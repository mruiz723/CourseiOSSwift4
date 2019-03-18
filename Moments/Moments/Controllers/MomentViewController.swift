//
//  MomentViewController.swift
//  Moments
//
//  Created by Marlon David Ruiz Arroyave on 3/13/19.
//  Copyright © 2019 Eafit. All rights reserved.
//

import UIKit

typealias ActionHandler = (UIAlertAction?) -> Void

class MomentViewController: UIViewController {

    // MARK: - Properties

    var moment: Moment?
    var userManager: UserManager?

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
        momentImageView.kf.setImage(with: URL(string: moment.imagePath))
        momentTextView.text = moment.descriptionMoment
    }

    private func presentAlertAskDeleteMoment(completionHandler: @escaping ActionHandler) {
        let yesAction = UIAlertAction(title: K.Action.yesActionTitle, style: .default, handler: { action in
            completionHandler(action)
        })

        let noAction = UIAlertAction(title: K.Action.noActionTitle, style: .cancel, handler: {_ in
            completionHandler(nil)
        })

        let message = "\(K.Message.messageDeleteMoment) \(moment?.title ?? "")'s moment?"
        UIAlertController.presentAlert(title: K.AlertTitle.moment,
                                       message: message,
                                       actions: [noAction, yesAction],
                                       fromController: self)
    }

    // MARK: - Actions

    @IBAction func deleteMoment(_ sender: Any) {
        presentAlertAskDeleteMoment { [unowned self]  action in
            guard action != nil else {
                return
            }
            self.userManager?.user?.getIDToken(completion: { [unowned self] token, error in
                guard let token = token, let idMoment = self.moment?.idMoment else {
                    // Handle error
                    print("There is a issue getting the token \(error?.localizedDescription ?? "!")")
                    return
                }

                Moment.deleteMoment(idMoment: idMoment,
                                    accessToken: token,
                                    completionHandler: { [unowned self] response in
                                        guard let error = response["error"] as? Error else {
                                            self.navigationController?.popViewController(animated: true)
                                            return
                                        }
                                        let oKAction = UIAlertAction(title: K.Action.okActionTitle,
                                                                     style: .default,
                                                                     handler: nil)
                                        UIAlertController.presentAlert(title: K.AlertTitle.moment,
                                                                       message: error.localizedDescription,
                                                                       actions: [oKAction],
                                                                       fromController: self)
                })
            })
        }
    }
}
