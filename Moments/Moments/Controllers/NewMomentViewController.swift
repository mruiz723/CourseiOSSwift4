//
//  NewMomentViewController.swift
//  Moments
//
//  Created by Marlon David Ruiz Arroyave on 3/13/19.
//  Copyright © 2019 Eafit. All rights reserved.
//

import UIKit
import AVFoundation

class NewMomentViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var momentImageView: UIImageView!
    @IBOutlet weak var momentTextView: UITextView!


    // MARK: - Lifecycle

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

    // MARK: - Actions
    
    @IBAction func createMoment(_ sender: Any) {

    }

    @IBAction func camera(_ sender: Any) {
        checkCamera()
    }

    func callCamera(){
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = .camera

        self.present(myPickerController, animated: true, completion: nil)
        NSLog("Camera");
    }

    func checkCamera() {
        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch authStatus {
        case .authorized: callCamera()
        case .denied: alertPromptToAllowCameraAccessViaSetting()
        case .notDetermined: alertToEncourageCameraAccessInitially()
        default: alertToEncourageCameraAccessInitially()
        }
    }

    func alertToEncourageCameraAccessInitially() {
        let alert = UIAlertController(
            title: "IMPORTANT",
            message: "Camera access required for capturing photos!",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Allow Camera", style: .cancel, handler: { (alert) -> Void in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        }))
        present(alert, animated: true, completion: nil)
    }

    func alertPromptToAllowCameraAccessViaSetting() {

        let alert = UIAlertController(
            title: "IMPORTANT",
            message: "Camera access required for capturing photos!",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel) { alert in
            let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back)
            if discoverySession.devices.count > 0 {
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    if granted {
                        DispatchQueue.main.async() {
                            self.checkCamera() } }
                }
            }
            }
        )
        present(alert, animated: true, completion: nil)
    }

}

extension NewMomentViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }

        // print out the image size as a test
        print(image.size)
        momentImageView.image = image
    }
}
