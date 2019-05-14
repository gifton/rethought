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
        backgroundColor = Device.colors.lightClay
    }
    
    // MARK: private variables
    private var bus: EntryComponentBus
    private var recording: Any?
    
    // MARK: Objects
    private let recordButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 32.5
        btn.backgroundColor = Device.colors.red
        btn.frame.size = CGSize(width: 65, height: 65)
        
        return btn
    }()
    private let finishedRecordingView = UIView()
    
    // set initial view
    private func setView() {
        addSubview(recordButton)
        
        recordButton.centerTo(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
