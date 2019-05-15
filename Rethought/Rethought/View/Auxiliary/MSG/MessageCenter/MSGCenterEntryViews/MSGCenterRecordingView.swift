//
//  MSGCenterRecordingView.swift
//  Rethought
//
//  Created by Dev on 5/12/19.
//  Copyright © 2019 Wesaturate. All rights reserved.
//

import Foundation
import UIKit

class MSGCenterRecordingView: UIView {
    init(bus: EntryComponentBus) {
        self.bus = bus
        super.init(frame: .zero)
        backgroundColor = Device.colors.recording
        setView(); styleView()
    }
    
    // MARK: private variables
    private var bus: EntryComponentBus
    private var recording: Any?
    
    // MARK: Objects
    private let recordButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 32.5
        btn.backgroundColor = Device.colors.red
        
        return btn
    }()
    private let titleLabel = UILabel()
    private let finishedRecordingView = UIView()
    
    // set initial view
    private func setView() {
        addSubview(recordButton)
        addSubview(finishedRecordingView)
        addSubview(titleLabel)
        
        //set height width - sets autotranslat... to false
        recordButton.setHeightWidth(width: 65, height: 65)
        recordButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50).isActive = true
        recordButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        titleLabel.setTopAndLeading(top: topAnchor, leading: leadingAnchor, paddingTop: 25, paddingLeading: 25)
        finishedRecordingView.setAnchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 20, paddingLeading: 30, paddingBottom: 0, paddingTrailing: 30)
        finishedRecordingView.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    // apply view styles
    private func styleView() {
        titleLabel.text = "New Recording"
        titleLabel.font = Device.font.title(ofSize: .xXXLarge)
        titleLabel.textColor = Device.colors.lightGray
        
        finishedRecordingView.layer.cornerRadius = 12.5
        finishedRecordingView.layer.borderColor = Device.colors.lightGray.cgColor
        finishedRecordingView.layer.borderWidth = 0.5
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
