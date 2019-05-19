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
    init(withBus bus: EntryComponentBus, thoughtIsCompleted: Bool) {
        self.bus = bus
        super.init(frame: .zero)
        backgroundColor = Device.colors.offWhite
        checkForCam()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var alertContent: String = "Tap to capture" {
        didSet {
            alertLabel.text = alertContent
        }
    }
    
    // MARK: objects
    private var photo: UIImage?
    private var bus: EntryComponentBus
    private var photoView: MSGCenterPreviewPhotoView?
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
    private let alertLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = Device.font.body(ofSize: .large)
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        
        return lbl
    }()
    private let photoLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = Device.font.title(ofSize: .xXXLarge)
        lbl.textColor = Device.colors.lightGray
        lbl.text = "New Photo"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
    }()
    
    // set initial view
    func setView() {
        photoView = MSGCenterPreviewPhotoView(frame: CGRect(x: 0, y: 0, width: Device.size.width, height: MSGContext.size.photo.rawValue),  bus: self)
        guard let photoView = photoView else {
            print("unable to instantiate photoview")
            return
        }
        addSubview(photoView)
        addSubview(photoLabel)
        addSubview(alertLabel)
        
        alertLabel.text = alertContent
        alertLabel.setAnchor(top: nil, leading: leadingAnchor, bottom: safeBottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 25, paddingBottom: 50, paddingTrailing: 25)
        photoLabel.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 25, paddingLeading: 25, paddingBottom: 0, paddingTrailing: 0)
    }

    // set photo to nil and reset view on tap
    private func didTapRetake() {
        photo = nil
        removeSubviews()
        setView()
    }
    
    public func requestContent(with detail: String) -> Bool {
        guard let photo = photo else { return false }
        let pb = PhotoBuilder(photo: photo, userDetail: detail, forEntry: nil)
        bus.save(withpayload: pb); return true
    }
    
    private func requestCancel() {
        bus.entryDidRequestCancel()
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
        // set local photo and imageView
        self.photo = photo
        
        newImage.image = photo
        // remove camera view
        guard let photoView = photoView else {
            print("unable to instantiate photoview")
            return
        }
        photoView.removeFromSuperview()
        alertLabel.removeFromSuperview()
        
        // add and set views
        addSubview(newImage)
        newImage.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, paddingTop: 15, paddingLeading: 25, paddingBottom: 130, paddingTrailing: 0)
        
        cancel.frame = CGRect(x: 50, y: frame.height - (80 + 32), width: 66, height: 32)
        retakePhoto.frame = CGRect(x: frame.width - 125, y: frame.height - (80 + 32), width: 66, height: 32)
        
        addSubview(cancel)
        addSubview(retakePhoto)
        
        // add targets
        retakePhoto.addTapGestureRecognizer { self.didTapRetake() }
        cancel.addTapGestureRecognizer{ self.requestCancel() }
        
        completion()
    }
    
    // check if permissions have been granted, else request permision
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
    
    //end session from MSGCenter
    public func endSession() {
        guard let photoView = photoView else {
            print("unable to instantiate photoview for session completion")
            return
        }
        photoView.endSession()
    }
    
    
    // set view if no thought is completed
    private func setForIncompleteCredentials() {
        let view = UIView(frame: frame)
        view.blurBackground(type: .regular)
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeading: 0, paddingBottom: 0, paddingTrailing: 0)
        
        let warningLbl = UILabel()
        warningLbl.font = Device.font.mediumTitle()
        warningLbl.text = "Add a new thought before adding an entry!"
        warningLbl.numberOfLines = 2
        warningLbl.translatesAutoresizingMaskIntoConstraints = false
        
        
        addSubview(warningLbl)
        warningLbl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        warningLbl.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
        warningLbl.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    // view will dissapear look-alike func
    public func unsetView() {
        removeSubviews()
        endSession()
        
        photo = nil
        photoView = nil
    }
}
