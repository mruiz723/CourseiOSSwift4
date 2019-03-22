//
//  NewMomentViewController.swift
//  Moments
//
//  Created by Marlon David Ruiz Arroyave on 3/13/19.
//  Copyright © 2019 Eafit. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseStorage
import SVProgressHUD

protocol NewMomentViewControllerDelegate: class {
    func newMomentDidCreated()
}

class NewMomentViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var momentImageView: UIImageView!
    @IBOutlet weak var momentTextView: UITextView!

    // MARK: - Properties
    var userManager: UserManager?
    let myPickerController = UIImagePickerController()
    weak var delegate: NewMomentViewControllerDelegate?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        myPickerController.delegate = self
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

    // MARK: - Actions

    @IBAction func createMoment(_ sender: Any) {
        SVProgressHUD.show()
        guard let title = titleTextField.text, let image = momentImageView.image,
            let imageData = image.pngData(), let descriptionMoment = momentTextView.text,
            let userManager = userManager, let email = userManager.user?.email else {
                let oKAction = UIAlertAction(title: K.Action.okActionTitle, style: .default, handler: nil)
                UIAlertController.presentAlert(title: K.AlertTitle.createMoment,
                                               message: K.Message.allFieldsAreRequired,
                                               actions: [oKAction], fromController: self)
                return
        }

        // Upload the image and get the url
        let path = "\(email)+\(Date().stringFromDate()).png"
        let storageRef = Storage.storage().reference().child(path)

        storageRef.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                storageRef.downloadURL(completion: { url, error in
                    guard let imagePath = url?.absoluteString else {
                        print(error?.localizedDescription ?? "")
                        return
                    }

                    userManager.user?.getIDToken(completion: { token, error in
                        guard let token = token else {
                            // Handle error
                            print("There is a issue getting the token \(error?.localizedDescription ?? "!")")
                            return
                        }

                        let params: [String: Any] = [
                            K.APIParameterKey.date: "\(Date().timeIntervalSince1970)",
                            K.APIParameterKey.title: title,
                            K.APIParameterKey.imagePath: imagePath,
                            K.APIParameterKey.descriptionMoment: descriptionMoment,
                            K.APIParameterKey.createdBy: email
                        ]

                        Moment.newMoment(params: params,
                                         accessToken: token,
                                         completionHandler: { [unowned self] response in
                                            SVProgressHUD.dismiss()
                                            
                                            guard let saved = response["moment"] as? [String: Any] else {
                                                let oKAction = UIAlertAction(title: K.Action.okActionTitle,
                                                                             style: .default,
                                                                             handler: nil)
                                                UIAlertController.presentAlert(title: K.AlertTitle.createMoment,
                                                                               message: K.Message.someWentWrong,
                                                                               actions: [oKAction],
                                                                               fromController: self)
                                                return
                                            }
                                            print("saved: \(saved)")
                                            self.delegate?.newMomentDidCreated()
                                            self.navigationController?.popViewController(animated: true)
                        })
                    })
                })
            }
        }
    }

    @IBAction func camera(_ sender: Any) {
        checkCamera()
    }

    @IBAction func photoLibrary(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            presentImagePicker(.photoLibrary)
        }
    }

}

extension NewMomentViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {

     // MARK: - Private Methods

    private func presentImagePicker(_ sourceType: UIImagePickerController.SourceType) {
        myPickerController.sourceType = sourceType
        myPickerController.allowsEditing = true
        self.present(myPickerController, animated: true, completion: nil)
    }

    private func checkCamera() {
        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch authStatus {
        case .authorized: presentImagePicker( .camera)
        case .denied: alertPromptToAllowCameraAccessViaSetting()
        case .notDetermined: alertToEncourageCameraAccessInitially()
        default: alertToEncourageCameraAccessInitially()
        }
    }

    private func alertToEncourageCameraAccessInitially() {
        let alert = UIAlertController(
            title: "IMPORTANT",
            message: "Camera access required for capturing photos!",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Allow Camera", style: .cancel, handler: { _ -> Void in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!,
                                      options: [:], completionHandler: nil)
        }))
        present(alert, animated: true, completion: nil)
    }

    private func alertPromptToAllowCameraAccessViaSetting() {

        let alert = UIAlertController(
            title: "IMPORTANT",
            message: "Camera access required for capturing photos!",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel) { _ in
            let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera],
                                                                    mediaType: .video, position: .back)
            if discoverySession.devices.count > 0 {
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    if granted {
                        DispatchQueue.main.async {
                            self.checkCamera() } }
                }
            }
            }
        )
        present(alert, animated: true, completion: nil)
    }

    // MARK: - UIImagePickerControllerDelegate

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        var image: UIImage?

        if let editedImage = info[.editedImage] as? UIImage {
            image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            image = originalImage
        }

        momentImageView.image = image!
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
