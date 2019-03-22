//
//  MomentsTableViewController.swift
//  Moments
//
//  Created by Marlon David Ruiz Arroyave on 3/13/19.
//  Copyright © 2019 Eafit. All rights reserved.
//

import UIKit
import FirebaseAuth
import Kingfisher
import SVProgressHUD

class MomentsTableViewController: UITableViewController {

    // MARK: - Properties

    var userManager: UserManager?
    var moments: [Moment]?

    override func viewDidLoad() {
        super.viewDidLoad()
        getMoments()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case K.Segue.moment:
            guard let momentVC = segue.destination as? MomentViewController, let moment = sender as? Moment else {
                return
            }
            momentVC.moment = moment
            momentVC.userManager = userManager
        case K.Segue.newMoment:
            guard let newMomentVC = segue.destination as? NewMomentViewController, let userManager = userManager else {
                return
            }
            newMomentVC.delegate = self
            newMomentVC.userManager = userManager
        default:
            return
        }

    }

    // MARK: - Private Methods

    private func getMoments() {
        SVProgressHUD.show()
        userManager?.user?.getIDToken(completion: { token, error in
            guard let token = token else {
                // Handle error
                print("There is a issue getting the token \(error?.localizedDescription ?? "!")")
                return
            }

            Moment.moments(token: token, completionHandler: { response in
                guard let data = response["moments"] as? [Moment] else {
                    return
                }

                self.moments = data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    SVProgressHUD.dismiss()
                }
            })
        })
    }

}

extension MomentsTableViewController {

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let count = moments?.count else {
            return 0
        }
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: K.CellIdentifier.moment,
                                                    for: indexPath) as? MomentCell,
            let moments = moments {
            let moment = moments[indexPath.row]
            cell.momentImageView.kf.setImage(with: URL(string: moment.imagePath))
            cell.dateLabel.text = moment.date.stringFromDate()
            cell.titleLabel.text = moment.title
            return cell
        }

        // Configure the cell...
        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let moment = moments?[indexPath.row] else {
            return
        }

        performSegue(withIdentifier: K.Segue.moment, sender: moment)
    }

    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */

    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle:
     UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class,
     // insert it into the array, and add a new row to the table view
     }
     }
     */

    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

     }
     */

    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */

}

extension MomentsTableViewController: NewMomentViewControllerDelegate {
    func newMomentDidCreated() {
        getMoments()
        tableView.reloadData()
    }
}
