//
//  MomentsTableViewController.swift
//  Moments2
//
//  Created by Usuario invitado on 10/12/19.
//  Copyright © 2019 Usuario invitado. All rights reserved.
//

import UIKit
import SVProgressHUD
import FirebaseAuth
import Kingfisher

class MomentsTableViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var momentsTableView: UITableView!

    // MARK: - Properties

    var userManager: UserManager?
    var moments: [Moment]?

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        getMoments()
        // Do any additional setup after loading the view.
    }

    // MARK: - Private Methods

    private func getMoments() {
        SVProgressHUD.show()
        userManager?.user?.getIDToken(completion: { (token, error) in
            guard let token = token else {
                print("Something went wrong")
                return
            }

            Moment.moments(token: token, completionHandler: { (response) in
                SVProgressHUD.dismiss()
                guard let data = response["moments"] as? [Moment] else {
                    return
                }

                self.moments = data

                DispatchQueue.main.async {
                    self.momentsTableView.reloadData()
                }
            })
        })
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        switch segue.identifier {
        case K.Segue.newMoment:
            guard let newMomentVC = segue.destination as? NewMomentViewController else {
                return
            }

            newMomentVC.userManager = userManager
            newMomentVC.delegate = self
        case K.Segue.moment:
            guard let momentVC = segue.destination as? MomentViewController, let moment = sender as? Moment else {
                return
            }
            momentVC.moment = moment
            momentVC.userManager = userManager
            momentVC.delegate = self
        default:
            return
        }
    }


}

extension MomentsTableViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moments?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.moment, for: indexPath) as? MomentCell, let moments = moments {

            let moment = moments[indexPath.row]
            cell.momentImageView.kf.setImage(with: URL(string: moment.imagePath))
            cell.dateLabel.text = moment.date.stringFromDate()
            cell.titleLabel.text = moment.title
            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let moment = moments?[indexPath.row] else {
            return
        }

        performSegue(withIdentifier: K.Segue.moment, sender: moment)
    }

}

extension MomentsTableViewController: NewMomentViewControllerDelegate {

    func newMomentDidCreate() {
        getMoments()
        self.momentsTableView.reloadData()
    }

}

extension MomentsTableViewController: MomentViewControllerDelegate {

    func userDidDeleteMoment(moment: Moment) {
        if let index = moments?.index(of: moment) {
            moments?.remove(at: index)
            momentsTableView.reloadData()
        }
    }

}
