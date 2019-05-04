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
    
    // set photo to nil and reset view on tap
    private func didTapRetake() {
        photo = nil
        removeSubviews()
        setView()
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
        photoView.removeFromSuperview()
        
        // add and set views
        addSubview(newImage)
        newImage.setAnchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, paddingTop: 15, paddingLeading: 25, paddingBottom: 130, paddingTrailing: 0)
        
        cancel.frame = CGRect(x: 50, y: frame.height - (80 + 32), width: 66, height: 32)
        retakePhoto.frame = CGRect(x: frame.width - 125, y: frame.height - (80 + 32), width: 66, height: 32)
        
        addSubview(cancel)
        addSubview(retakePhoto)
        
        // add targets
        retakePhoto.addTapGestureRecognizer {
            self.didTapRetake()
        }
        
        completion()
    }
}
