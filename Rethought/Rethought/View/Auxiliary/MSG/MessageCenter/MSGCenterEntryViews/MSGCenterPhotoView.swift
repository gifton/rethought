//
//  MSGCenterPhotoView.swift
//  Rethought
//
//  Created by Dev on 5/3/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class MSGCenterPhotoView: UIView {
    init(withBus bus: EntryComponentBus) {
        self.bus = bus
        super.init(frame: .zero)
        backgroundColor = Device.colors.offWhite
        checkForCam()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func checkForCam() {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            if response {
                DispatchQueue.main.async { self.setView()
                }
            } else {
                fatalError()
            }
        }
    }
    
    private var photo: UIImage?
    private var bus: EntryComponentBus
    private var photoView: MSGCenterPreviewPhotoView!
    private let newImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        iv.backgroundColor = Device.colors.yellow
        
        return iv
    }()
    private let retakePhoto: UIButton = {
        let btn = UIButton()
        let attrString = NSAttributedString(string: "retake", attributes: [NSAttributedString.Key.font : Device.font.mediumTitle(ofSize: .large),
                                                                         NSAttributedString.Key.foregroundColor : Device.colors.lightGray])
        btn.setAttributedTitle(attrString, for: .normal)
        
        return btn
    }()
    private let cancel: UIButton = {
        let btn = UIButton()
        let attrString = NSAttributedString(string: "cancel", attributes: [NSAttributedString.Key.font : Device.font.mediumTitle(ofSize: .large),
                                                                           NSAttributedString.Key.foregroundColor : Device.colors.red])
        btn.setAttributedTitle(attrString, for: .normal)
        
        return btn
    }()
    
    func setView() {
        photoView = MSGCenterPreviewPhotoView(frame: CGRect(x: 0, y: 0, width: Device.size.width, height: MSGContext.size.photo.rawValue), bus: self)
        addSubview(photoView)
    }
}

extension MSGCenterPhotoView: MSGCenterEntryView, MSGCenterPhotoBus {
    var minimumComponentsCompleted: Bool {
        return !(photo == nil)
    }
    
    var entryType: EntryType {
        return .photo
    }
    
    func photoTaken(_ photo: UIImage, completion: () -> Void) {
        self.photo = photo
        newImage.image = photo
        photoView.removeFromSuperview()
        addSubview(newImage)
        newImage.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, paddingTop: 15, paddingLeading: 25, paddingBottom: 130, paddingTrailing: 0)
        
        cancel.frame = CGRect(x: 50, y: frame.height - (80 + 32), width: 66, height: 32)
        retakePhoto.frame = CGRect(x: frame.width - 125, y: frame.height - (80 + 32), width: 66, height: 32)
        
        addSubview(cancel)
        addSubview(retakePhoto)
        completion()
    }
}




protocol MSGCenterPhotoBus {
    func photoTaken(_ photo: UIImage, completion: () -> Void)
}

class MSGCenterPreviewPhotoView: UIView {
    
    init(frame: CGRect, bus: MSGCenterPhotoBus) {
        self.bus = bus
        super.init(frame: frame)
        setView()
        backgroundColor = .black
        self.addTapGestureRecognizer {
            self.didTakePhoto()
        }
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: Private vars
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var interactionLabel = UILabel()
    var previewLayer: AVCaptureVideoPreviewLayer!
    var bus: MSGCenterPhotoBus
    
    func setView() {
        // create capture session, .medium for meh quality photos
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .medium
        //guard into back camera
        //TODO: add front camera support
        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video) else { print("Unable to access back camera"); return }
        
        do {
            // recieve input
            let input = try AVCaptureDeviceInput(device: backCamera)
            stillImageOutput = AVCapturePhotoOutput()
            
            // check if input and output is validated
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                setupLivePreview()
            }
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
        
        
    }
    
    func setupLivePreview() {
        print("setting up live preview")
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.connection?.videoOrientation = .portrait
        layer.addSublayer(previewLayer)
        
        DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
            self.captureSession.startRunning()
            DispatchQueue.main.async {
                self.previewLayer.frame = self.bounds
            }
        }
        
        
    }
    
    private func didTakePhoto() {
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        stillImageOutput.capturePhoto(with: settings, delegate: self)
        print("we took an image!")
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation()
            else { return }
        
        guard let  image = UIImage(data: imageData) else {
            print ("unable to process photo from session")
            return
        }
        
        bus.photoTaken(image, completion: endSession)
        print("we sent the image!")
    }
    
    private func endSession() {
        captureSession.stopRunning()
    }
}

extension MSGCenterPreviewPhotoView: AVCapturePhotoCaptureDelegate { }
