//
//  NewMomentViewController.swift
//  Moments20191
//
//  Created by Usuario invitado on 13/6/19.
//  Copyright © 2019 eafit. All rights reserved.
//

import UIKit
import SVProgressHUD
import FirebaseStorage
import AVFoundation

protocol NewMomentViewControllerDelegate: class {
    func newMomentDidCreate()
}

class NewMomentViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var titleTextView: UITextField!
    @IBOutlet weak var momentImageView: UIImageView!
    @IBOutlet weak var momentTextView: UITextView!
    
    // MARK: - Properties
    var userManager: UserManager?
    weak var delegate: NewMomentViewControllerDelegate?
    let myPickerController: UIImagePickerController = UIImagePickerController()
    
    // MARK: - IBActions
    
    @IBAction func createMoment(_ sender: Any) {
        SVProgressHUD.show()
        guard let title = titleTextView.text, let image = momentImageView.image, let imageData = image.pngData(),
            let userManager = userManager, let email = userManager.user?.email, let descriptionMoment = momentTextView.text else {
                let okAction = UIAlertAction(title: K.AlertAction.okActionTitle, style: .default, handler: nil)
                UIAlertController.presentAlert(title: K.AlertTitle.createMoment, message: K.Message.allFieldsAreRequired, actions: [okAction], fromController: self)
            return
        }
        
        //Upload image to Storage
        let path = "\(email)+\(Date().stringFromDate()).png"
        let storageRef = Storage.storage().reference().child(path)
        
        storageRef.putData(imageData, metadata: nil) { _, error in
            if let _ = error {
                self.showAlertSomeWentWrong()
                return
            } else {
                storageRef.downloadURL(completion: { url, error in
                    guard let imagePath = url?.absoluteString else {
                        self.showAlertSomeWentWrong()
                        return
                    }
                    
                    // Token
                    userManager.user?.getIDToken(completion: { (token, error) in
                        guard let token = token else {
                            self.showAlertSomeWentWrong()
                            return
                        }
                        
                        // params
                        let params: [String: Any] = [
                            K.APIParameterKey.date: "\(Date().timeIntervalSince1970)",
                            K.APIParameterKey.title: title,
                            K.APIParameterKey.imagePath: imagePath,
                            K.APIParameterKey.descriptionMoment: descriptionMoment,
                            K.APIParameterKey.createdBy: email
                        ]
                        
                        Moment.newMoment(params: params, accessToken: token, completionHandler: { [unowned self] (response) in
                                SVProgressHUD.dismiss()
                            
                            guard let _ = response["moment"] as? [String: Any] else {
                                self.showAlertSomeWentWrong()
                                return
                            }
//                            print("saved: \(saved)")
                            self.delegate?.newMomentDidCreate()
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
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Private Methods
    
    fileprivate func showAlertSomeWentWrong() {
        let okAction = UIAlertAction(title: K.AlertAction.okActionTitle, style: .default, handler: nil)
        UIAlertController.presentAlert(title: K.AlertTitle.createMoment, message: K.Message.someWentWrong, actions: [okAction], fromController: self)
    }
    
    private func checkCamera() {
        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch authStatus {
        case .authorized: presentImagePicker(.camera)
        case .denied: alertPromptToAllowCameraAccessViaSetting()
        case .notDetermined: alertToEncourageCameraAccessInitially()
        default:alertToEncourageCameraAccessInitially()
        }
    }
    
    private func presentImagePicker(_ sourceType: UIImagePickerController.SourceType) {
        myPickerController.sourceType = sourceType
        myPickerController.allowsEditing = true
        self.present(myPickerController, animated: true, completion: nil)
    }
    
    private func alertPromptToAllowCameraAccessViaSetting() {
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: { _  in
            let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back)
            
            if discoverySession.devices.count > 0 {
                AVCaptureDevice.requestAccess(for: .video, completionHandler: { [unowned self] (granted) in
                    if granted {
                        DispatchQueue.main.async {
                            self.checkCamera()
                        }
                    }
                })
            }
        })
        
        UIAlertController.presentAlert(title: K.AlertTitle.important, message: K.Message.requiredCamera, actions: [dismissAction], fromController: self)
    }
    
    private func alertToEncourageCameraAccessInitially() {
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let allowAction = UIAlertAction(title: "Allow", style: .default, handler: { _ in
            guard let url = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        })
        UIAlertController.presentAlert(title: K.AlertTitle.important, message: K.Message.requiredCamera, actions: [cancelAction, allowAction], fromController: self)
    }

}

extension NewMomentViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var image: UIImage?
        
        if let editedImage = info[.editedImage] as? UIImage {
            image = editedImage
        } else if let origialImage = info[.originalImage] as? UIImage {
            image = origialImage
        }
        
        momentImageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
}
