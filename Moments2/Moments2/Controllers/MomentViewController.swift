//
//  MomentViewController.swift
//  Moments2
//
//  Created by Usuario invitado on 10/12/19.
//  Copyright © 2019 Usuario invitado. All rights reserved.
//

import UIKit

typealias ActionHandler = (UIAlertAction?) -> Void

protocol MomentViewControllerDelegate: class {
    func userDidDeleteMoment(moment: Moment)
}

class MomentViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var momentImageView: UIImageView!
    @IBOutlet weak var momentTextView: UITextView!

    // MARK: - Properties
    var userManager: UserManager?
    var moment: Moment?
    weak var delegate: MomentViewControllerDelegate?

    // MARK: - IBActions

    @IBAction func deleteMoment(_ sender: Any) {
        presentAlertAskDeleteMoment { [unowned self]  action in
            guard action != nil else {
                return
            }
            self.userManager?.user?.getIDToken(completion: { [unowned self] token, error in
                guard let token = token, let moment = self.moment else {
                    // Handle error
                    print("There is a issue getting the token \(error?.localizedDescription ?? "!")")
                    return
                }

                Moment.deleteMoment(idMoment: moment.idMoment,
                                    accessToken: token,
                                    completionHandler: { [unowned self] response in
                                        guard let error = response[K.error] as? Error else {
                                            self.navigationController?.popViewController(animated: true)
                                            self.delegate?.userDidDeleteMoment(moment: moment)
                                            return
                                        }
                                        let oKAction = UIAlertAction(title: K.AlertAction.okActionTitle,
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

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    private func setupViews() {
        guard let moment = moment else {
            return
        }

        dateLabel.text = moment.date.stringFromDate()
        titleLabel.text = moment.title
        momentImageView.kf.setImage(with: URL(string: moment.imagePath))
        momentTextView.text = moment.descriptionMoment
    }

    private func presentAlertAskDeleteMoment(completionHandler: @escaping ActionHandler) {
        let yesAction = UIAlertAction(title: K.AlertAction.yesActionTitle, style: .default, handler: { action in
            completionHandler(action)
        })

        let noAction = UIAlertAction(title: K.AlertAction.noActionTitle, style: .cancel, handler: {_ in
            completionHandler(nil)
        })

        let message = "\(K.Message.messageDeleteMoment) \(moment?.title ?? "")'s moment?"
        UIAlertController.presentAlert(title: K.AlertTitle.moment,
                                       message: message,
                                       actions: [noAction, yesAction],
                                       fromController: self)
    }

}
