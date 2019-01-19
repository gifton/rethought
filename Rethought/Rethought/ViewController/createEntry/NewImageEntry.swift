//
//  NewImageEntry.swift
//  rethought
//
//  Created by Dev on 1/16/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit
import AVKit

class NewImageEntry: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        cameraButton.frame = CGRect(x: (ViewSize.SCREEN_WIDTH - 150) / 2, y: 450, width: 150, height: 150)
        cameraButton.layer.cornerRadius = 6
        cameraButton.setImage(#imageLiteral(resourceName: "camera-alt"), for: .normal)
        cameraButton.backgroundColor = .darkBackground
        imageViewer.frame.size = CGSize(width: 50, height: 50)
        imageViewer.center.x = self.view.center.x
        imageViewer.center.y = 190
        doneButton.frame = CGRect(x: 25, y: ViewSize.SCREEN_HEIGHT - 99, width: ViewSize.SCREEN_WIDTH - 50, height: 59)
//        imageViewer.frame = CGRect(x: 150, y: 90, width: 150, height: 150)
        
        view.addSubview(titleTextField)
        view.addSubview(cameraButton)
        view.addSubview(doneButton)
        view.addSubview(imageViewer)
        
        cameraButton.addTarget(self, action: #selector(addCam(_:)), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(userPressedSave(_:)), for: .touchUpInside)
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
    }
    
    public var entry          : Entry?
    public var delegate       : ThoughtCardDelegate?
    public var parentThought  : Thought?
    private var newDescription: String {
        get {
            return String(describing: self.titleTextField.attributedText ?? NSAttributedString(string: ""))
        }
    }
    private var descriptionString: String {
        get {
            return self.entry?.detail ?? "please add a description"
        }
    }
    
    var titleTextField = ReTextField(frame: CGRect(x: 25, y: 350, width: ViewSize.SCREEN_WIDTH - 50, height: 59), attPlaceholder: "Add a title for your entry")
    var cameraButton = UIButton()
    var doneButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(hex: "6271fc")
        btn.setAttributedTitle(btn.addAttributedText(size: 12, font: .title, string: "Save"), for: .normal)
        btn.layer.cornerRadius = 6
        
        return btn
    }()
    
    var imageViewer: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "imagePlaceholder")
        iv.layer.cornerRadius = 6
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let incompleteLabel: UILabel = {
        let lbl = UILabel()
        lbl.layer.cornerRadius = 5
        lbl.addText(color: .white, size: fontSize.small.rawValue, font: .bodyLight, string: "Please enter a title and description")
        lbl.textAlignment = .center
        lbl.backgroundColor = .darkBackground
        lbl.layer.masksToBounds = true
        lbl.layer.opacity = 0.0
        
        return lbl
    }()
    
}

extension NewImageEntry: UIImagePickerControllerDelegate {
    @objc
    func addCam(_ sender: UIButton) {
        
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch cameraAuthorizationStatus {
            case .notDetermined: requestCameraPermission()
            case .authorized: presentCamera()
            case .restricted, .denied: alertCameraAccessNeeded()
        }
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard var image = info[.originalImage] as? UIImage else {
            print("No image found")
            picker.dismiss(animated: true)
            return
        }
        image = image.resizeImage(250, opaque: false)
        
        self.imageViewer.frame.size = image.size
        self.imageViewer.image = image
        imageViewer.center.x = self.view.center.x
        imageViewer.center.y = 175
        
        picker.dismiss(animated: true)
    }
    
    func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: {accessGranted in
            guard accessGranted == true else { return }
            self.presentCamera()
        })
    }
    
    func presentCamera() {
        let photoPicker = UIImagePickerController()
        photoPicker.sourceType = .camera
        photoPicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        self.present(photoPicker, animated: true, completion: nil)
    }
    
    func alertCameraAccessNeeded() {
        let settingsAppURL = URL(string: UIApplication.openSettingsURLString)!
        
        let alert = UIAlertController(
            title: "Need Camera Access",
            message: "Camera access is required to make full use of this app.",
            preferredStyle: UIAlertController.Style.alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Allow Camera", style: .cancel, handler: { (alert) -> Void in
            UIApplication.shared.open(settingsAppURL, options: [:], completionHandler: nil)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc
    func userPressedSave(_ sender: UIButton) {
        if self.newDescription != "" && imageViewer.image != UIImage(named: "imagePlaceholder.png"){
            let entry = Entry(type: .image, thoughtID: parentThought?.ID ?? "nil", detail: newDescription, date: Date(), icon: parentThought?.icon ?? "🍤", image: imageViewer.image!)
            self.delegate?.addEntry(entry)
            self.navigationController?.popViewController(animated: true)
            
        } else {
            incompleteLabel.frame = CGRect(x: 25, y: ViewSize.SCREEN_HEIGHT - 200, width: ViewSize.SCREEN_WIDTH - 50, height: 59)
            self.view.addSubview(incompleteLabel)
            self.view.animateTemporaryView(duration: 1.0, view: incompleteLabel)
        }
    }
}

extension NewImageEntry {
    @objc
    func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .recognized {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension NewImageEntry: UINavigationControllerDelegate {
    
}
